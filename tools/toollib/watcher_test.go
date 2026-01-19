package toollib

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/fsnotify/fsnotify"
)

func TestIsHiddenOrBackup(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{".hidden", true},
		{".gitignore", true},
		{"backup~", true},
		{"file.txt~", true},
		{"normal.txt", false},
		{"01-hello.sh", false},
		{".bash_profile", true},
		{"test.sh", false},
		{"", true}, // empty string should be treated as hidden
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := IsHiddenOrBackup(tt.input)
			if result != tt.expected {
				t.Errorf("IsHiddenOrBackup(%q) = %v, want %v", tt.input, result, tt.expected)
			}
		})
	}
}

func TestIsWatchedScript(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{"/examples/hello-world/01-hello.sh", true},
		{"/examples/test/99-foo.bash", true},
		{"examples/vars/02-test.sh", true},
		{"/examples/hello-world/01-hello.txt", false},
		{"/examples/hello-world/.01-hidden.sh", false},
		{"/examples/hello-world/01-backup.sh~", false},
		{"/examples/hello-world/hello.sh", false}, // no number
		{"", false},
		{"/test.sh", false}, // no numbered prefix in path
		{"/01-test.output.txt", false},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := IsWatchedScript(tt.input)
			if result != tt.expected {
				t.Errorf("IsWatchedScript(%q) = %v, want %v", tt.input, result, tt.expected)
			}
		})
	}
}

func TestAddWatchRecursive(t *testing.T) {
	// Create a temp directory structure
	tmpDir := t.TempDir()

	// Create nested directories
	dirs := []string{
		filepath.Join(tmpDir, "a"),
		filepath.Join(tmpDir, "a", "b"),
		filepath.Join(tmpDir, "a", "b", "c"),
		filepath.Join(tmpDir, "d"),
	}
	for _, dir := range dirs {
		if err := os.MkdirAll(dir, 0755); err != nil {
			t.Fatalf("creating directory %s: %v", dir, err)
		}
	}

	// Create a watcher
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		t.Fatalf("creating watcher: %v", err)
	}
	defer watcher.Close()

	// Add watches recursively
	if err := AddWatchRecursive(watcher, tmpDir); err != nil {
		t.Fatalf("AddWatchRecursive error: %v", err)
	}

	// Verify all directories are being watched
	// Note: fsnotify doesn't provide a way to list watched paths,
	// so we verify by checking no error was returned and the function completed
}

func TestAddWatchRecursive_SingleDir(t *testing.T) {
	tmpDir := t.TempDir()

	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		t.Fatalf("creating watcher: %v", err)
	}
	defer watcher.Close()

	if err := AddWatchRecursive(watcher, tmpDir); err != nil {
		t.Fatalf("AddWatchRecursive error: %v", err)
	}
}

func TestAddWatchRecursive_NonexistentDir(t *testing.T) {
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		t.Fatalf("creating watcher: %v", err)
	}
	defer watcher.Close()

	err = AddWatchRecursive(watcher, "/nonexistent/directory")
	if err == nil {
		t.Error("expected error for nonexistent directory")
	}
}

func TestAddWatchRecursive_WithFiles(t *testing.T) {
	tmpDir := t.TempDir()

	// Create directories and files
	subDir := filepath.Join(tmpDir, "subdir")
	if err := os.MkdirAll(subDir, 0755); err != nil {
		t.Fatalf("creating subdir: %v", err)
	}

	// Create some files (these should be skipped, only directories are watched)
	files := []string{
		filepath.Join(tmpDir, "file1.txt"),
		filepath.Join(subDir, "file2.txt"),
	}
	for _, f := range files {
		if err := os.WriteFile(f, []byte("content"), 0644); err != nil {
			t.Fatalf("creating file %s: %v", f, err)
		}
	}

	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		t.Fatalf("creating watcher: %v", err)
	}
	defer watcher.Close()

	if err := AddWatchRecursive(watcher, tmpDir); err != nil {
		t.Fatalf("AddWatchRecursive error: %v", err)
	}
}

func TestIsWatchedScript_EdgeCases(t *testing.T) {
	tests := []struct {
		name     string
		input    string
		expected bool
	}{
		{"just extension", ".sh", false},
		{"just bash extension", ".bash", false},
		{"numbered but wrong extension", "/path/01-test.py", false},
		{"valid sh in subdir", "foo/bar/01-test.sh", true},
		{"valid bash in subdir", "foo/bar/01-test.bash", true},
		{"hidden numbered", "/path/.01-test.sh", false},
		{"backup numbered", "/path/01-test.sh~", false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := IsWatchedScript(tt.input)
			if result != tt.expected {
				t.Errorf("IsWatchedScript(%q) = %v, want %v", tt.input, result, tt.expected)
			}
		})
	}
}
