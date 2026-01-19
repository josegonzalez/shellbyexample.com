package toollib

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/fsnotify/fsnotify"
)

// AddWatchRecursive adds a directory and all its subdirectories to the watcher.
func AddWatchRecursive(watcher *fsnotify.Watcher, root string) error {
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

// IsHiddenOrBackup checks if a filename is hidden (starts with .) or a backup file (ends with ~).
func IsHiddenOrBackup(filename string) bool {
	if len(filename) == 0 {
		return true
	}
	return filename[0] == '.' || filename[len(filename)-1] == '~'
}

// IsWatchedScript checks if a file is a numbered script we should watch.
func IsWatchedScript(path string) bool {
	base := filepath.Base(path)

	// Ignore hidden files and backup files
	if IsHiddenOrBackup(base) {
		return false
	}

	// Must be .sh or .bash file
	if !strings.HasSuffix(path, ".sh") && !strings.HasSuffix(path, ".bash") {
		return false
	}

	// Must match numbered pattern (e.g., /01-something.sh)
	if !NumberedFilePathPattern.MatchString(path) {
		return false
	}

	return true
}
