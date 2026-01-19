//go:build ignore

package main

import (
	"fmt"
	"os"
	"time"

	"github.com/fsnotify/fsnotify"
	"github.com/josegonzalez/shellbyexample.com/tools/toollib"
)

func main() {
	// Set up watcher
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to create watcher: %v\n", err)
		os.Exit(1)
	}
	defer watcher.Close()

	// Add examples directory recursively
	if err := toollib.AddWatchRecursive(watcher, toollib.ExamplesDir); err != nil {
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
			if !toollib.IsWatchedScript(event.Name) {
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

// regenerateOutput runs the script in Docker and writes its output
func regenerateOutput(scriptPath string) {
	outputPath := toollib.OutputPathForScript(scriptPath)

	fmt.Printf("Regenerating output for %s...\n", scriptPath)

	// Check if script needs network access
	needsNetwork := toollib.ScriptNeedsNetwork(scriptPath)

	// Run the script in Docker
	output, err := toollib.RunScriptInDocker(scriptPath, needsNetwork)

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
