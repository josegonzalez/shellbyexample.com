//go:build ignore

package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"time"

	"github.com/fsnotify/fsnotify"
	"github.com/josegonzalez/shellbyexample.com/tools/toollib"
)

func main() {
	// Initial build
	fmt.Println("Running initial build...")
	if err := runBuild(); err != nil {
		fmt.Fprintf(os.Stderr, "Initial build failed: %v\n", err)
	}

	// Set up watcher
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to create watcher: %v\n", err)
		os.Exit(1)
	}
	defer watcher.Close()

	// Add directories recursively
	if err := toollib.AddWatchRecursive(watcher, toollib.ExamplesDir); err != nil {
		fmt.Fprintf(os.Stderr, "Failed to watch examples/: %v\n", err)
		os.Exit(1)
	}
	if err := toollib.AddWatchRecursive(watcher, "templates"); err != nil {
		fmt.Fprintf(os.Stderr, "Failed to watch templates/: %v\n", err)
		os.Exit(1)
	}
	if err := watcher.Add("examples.txt"); err != nil {
		fmt.Fprintf(os.Stderr, "Failed to watch examples.txt: %v\n", err)
		os.Exit(1)
	}

	fmt.Println("Watching for changes in examples/, templates/, and examples.txt...")
	fmt.Println("Press Ctrl+C to stop.")

	// Event loop with debouncing
	var debounceTimer *time.Timer
	debounceDuration := 100 * time.Millisecond

	for {
		select {
		case event, ok := <-watcher.Events:
			if !ok {
				return
			}

			// Only rebuild on write/create/remove events
			if event.Op&(fsnotify.Write|fsnotify.Create|fsnotify.Remove) == 0 {
				continue
			}

			// Ignore temporary/hidden files
			base := filepath.Base(event.Name)
			if toollib.IsHiddenOrBackup(base) {
				continue
			}

			// Describe the change type
			var changeType string
			switch {
			case event.Op&fsnotify.Rename != 0:
				changeType = "renamed"
			case event.Op&fsnotify.Remove != 0:
				changeType = "deleted"
			case event.Op&fsnotify.Create != 0:
				changeType = "created"
				// Watch newly created directories
				if info, err := os.Stat(event.Name); err == nil && info.IsDir() {
					if err := toollib.AddWatchRecursive(watcher, event.Name); err != nil {
						fmt.Fprintf(os.Stderr, "Failed to watch new directory %s: %v\n", event.Name, err)
					}
				}
			default:
				changeType = "modified"
			}

			fmt.Printf("File %s: %s\n", changeType, event.Name)

			// Debounce: reset timer on each event
			if debounceTimer != nil {
				debounceTimer.Stop()
			}
			debounceTimer = time.AfterFunc(debounceDuration, func() {
				fmt.Println("Rebuilding...")
				if err := runBuild(); err != nil {
					fmt.Fprintf(os.Stderr, "Build failed: %v\n", err)
				} else {
					fmt.Println("Build complete.")
				}
			})

		case err, ok := <-watcher.Errors:
			if !ok {
				return
			}
			fmt.Fprintf(os.Stderr, "Watcher error: %v\n", err)
		}
	}
}

// runBuild executes the site generator
func runBuild() error {
	cmd := exec.Command("go", "run", "tools/generate.go")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}
