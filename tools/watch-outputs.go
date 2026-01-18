//go:build ignore

package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
	"time"

	"github.com/fsnotify/fsnotify"
)

var numberedFilePattern = regexp.MustCompile(`/[0-9]{2}-`)

func main() {
	// Set up watcher
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to create watcher: %v\n", err)
		os.Exit(1)
	}
	defer watcher.Close()

	// Add examples directory recursively
	if err := addWatchRecursive(watcher, "examples"); err != nil {
		fmt.Fprintf(os.Stderr, "Failed to watch examples/: %v\n", err)
		os.Exit(1)
	}

	fmt.Println("Watching for .sh and .bash file changes in examples/...")
	fmt.Println("Press Ctrl+C to stop.")

	// Track pending regenerations with debouncing
	pendingFiles := make(map[string]*time.Timer)
	debounceDuration := 100 * time.Millisecond

	for {
		select {
		case event, ok := <-watcher.Events:
			if !ok {
				return
			}

			// Only process write/create events
			if event.Op&(fsnotify.Write|fsnotify.Create) == 0 {
				continue
			}

			// Check if it's a script file we care about
			if !isWatchedScript(event.Name) {
				continue
			}

			// Cancel any pending timer for this file
			if timer, exists := pendingFiles[event.Name]; exists {
				timer.Stop()
			}

			// Set up debounced regeneration
			scriptPath := event.Name
			pendingFiles[scriptPath] = time.AfterFunc(debounceDuration, func() {
				delete(pendingFiles, scriptPath)
				regenerateOutput(scriptPath)
			})

		case err, ok := <-watcher.Errors:
			if !ok {
				return
			}
			fmt.Fprintf(os.Stderr, "Watcher error: %v\n", err)
		}
	}
}

// isWatchedScript checks if a file is a script we should watch
func isWatchedScript(path string) bool {
	base := filepath.Base(path)

	// Ignore hidden files and backup files
	if len(base) == 0 || base[0] == '.' || base[len(base)-1] == '~' {
		return false
	}

	// Must be .sh or .bash file
	if !strings.HasSuffix(path, ".sh") && !strings.HasSuffix(path, ".bash") {
		return false
	}

	// Must match numbered pattern (e.g., 01-something.sh)
	if !numberedFilePattern.MatchString(path) {
		return false
	}

	return true
}

// addWatchRecursive adds a directory and all subdirectories to the watcher
func addWatchRecursive(watcher *fsnotify.Watcher, root string) error {
	return filepath.WalkDir(root, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if d.IsDir() {
			if err := watcher.Add(path); err != nil {
				return fmt.Errorf("watching %s: %w", path, err)
			}
		}
		return nil
	})
}

// regenerateOutput runs the script in Docker and writes its output
func regenerateOutput(scriptPath string) {
	// Determine output file path
	ext := filepath.Ext(scriptPath)
	outputPath := strings.TrimSuffix(scriptPath, ext) + ".output.txt"

	fmt.Printf("Regenerating output for %s...\n", scriptPath)

	// Run the script in Docker
	cmd := exec.Command("./tools/run-in-docker.sh", scriptPath)
	output, err := cmd.CombinedOutput()

	// Write output to file (even if script failed, we want to capture the error)
	if writeErr := os.WriteFile(outputPath, output, 0644); writeErr != nil {
		fmt.Fprintf(os.Stderr, "Failed to write %s: %v\n", outputPath, writeErr)
		return
	}

	if err != nil {
		fmt.Printf("Script %s exited with error (output saved): %v\n", scriptPath, err)
	} else {
		fmt.Printf("Output written to %s\n", outputPath)
	}
}
