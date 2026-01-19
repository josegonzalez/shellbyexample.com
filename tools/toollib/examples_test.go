package toollib

import (
	"os"
	"path/filepath"
	"strings"
	"testing"
)

func TestFindCategoryScripts(t *testing.T) {
	tmpDir := t.TempDir()

	// Create test files
	files := []string{
		"01-hello.sh",
		"02-world.bash",
		"03-test.sh",
		"readme.md",
		"config.txt",
	}
	for _, f := range files {
		if err := os.WriteFile(filepath.Join(tmpDir, f), []byte("#!/bin/sh"), 0644); err != nil {
			t.Fatalf("creating test file %s: %v", f, err)
		}
	}

	// Create a subdirectory (should be ignored)
	if err := os.MkdirAll(filepath.Join(tmpDir, "subdir"), 0755); err != nil {
		t.Fatalf("creating subdir: %v", err)
	}

	scripts, err := FindCategoryScripts(tmpDir)
	if err != nil {
		t.Fatalf("FindCategoryScripts error: %v", err)
	}

	if len(scripts) != 3 {
		t.Errorf("got %d scripts, want 3", len(scripts))
	}

	// Check that all returned scripts match the pattern
	for _, s := range scripts {
		base := filepath.Base(s)
		if !NumberedScriptPattern.MatchString(base) {
			t.Errorf("unexpected script returned: %s", s)
		}
	}
}

func TestFindCategoryScripts_EmptyDir(t *testing.T) {
	tmpDir := t.TempDir()

	scripts, err := FindCategoryScripts(tmpDir)
	if err != nil {
		t.Fatalf("FindCategoryScripts error: %v", err)
	}

	if len(scripts) != 0 {
		t.Errorf("got %d scripts, want 0 for empty dir", len(scripts))
	}
}

func TestFindCategoryScripts_NonexistentDir(t *testing.T) {
	_, err := FindCategoryScripts("/nonexistent/directory")
	if err == nil {
		t.Error("expected error for nonexistent directory")
	}
	if !strings.Contains(err.Error(), "reading directory") {
		t.Errorf("error = %q, want to contain 'reading directory'", err.Error())
	}
}

func TestFindAllScripts(t *testing.T) {
	// This test uses the actual examples directory
	// Skip if not in the project root
	if _, err := os.Stat("examples"); os.IsNotExist(err) {
		t.Skip("examples directory not found - not in project root")
	}

	scripts, err := FindAllScripts()
	if err != nil {
		t.Fatalf("FindAllScripts error: %v", err)
	}

	if len(scripts) == 0 {
		t.Error("expected at least some scripts")
	}

	// Check that all returned scripts match the pattern
	for _, s := range scripts {
		base := filepath.Base(s)
		if !NumberedScriptPattern.MatchString(base) {
			t.Errorf("unexpected script returned: %s", s)
		}
	}
}

func TestFindAllScripts_WithTempDir(t *testing.T) {
	// Save original ExamplesDir and restore after test
	origDir, err := os.Getwd()
	if err != nil {
		t.Fatalf("getting working directory: %v", err)
	}

	// Create a temp directory structure
	tmpDir := t.TempDir()
	examplesDir := filepath.Join(tmpDir, "examples")

	// Create category directories with scripts
	categories := []string{"hello-world", "variables"}
	for _, cat := range categories {
		catDir := filepath.Join(examplesDir, cat)
		if err := os.MkdirAll(catDir, 0755); err != nil {
			t.Fatalf("creating category dir: %v", err)
		}
		// Create a script in each category
		scriptPath := filepath.Join(catDir, "01-test.sh")
		if err := os.WriteFile(scriptPath, []byte("#!/bin/sh\necho test"), 0644); err != nil {
			t.Fatalf("creating script: %v", err)
		}
	}

	// Change to temp directory to test FindAllScripts
	if err := os.Chdir(tmpDir); err != nil {
		t.Fatalf("changing to temp dir: %v", err)
	}
	defer os.Chdir(origDir)

	scripts, err := FindAllScripts()
	if err != nil {
		t.Fatalf("FindAllScripts error: %v", err)
	}

	if len(scripts) != 2 {
		t.Errorf("got %d scripts, want 2", len(scripts))
	}
}

func TestFindAllScripts_NoExamplesDir(t *testing.T) {
	origDir, err := os.Getwd()
	if err != nil {
		t.Fatalf("getting working directory: %v", err)
	}

	tmpDir := t.TempDir()
	if err := os.Chdir(tmpDir); err != nil {
		t.Fatalf("changing to temp dir: %v", err)
	}
	defer os.Chdir(origDir)

	_, err = FindAllScripts()
	if err == nil {
		t.Error("expected error when examples directory doesn't exist")
	}
}

func TestValidateCategoryDir(t *testing.T) {
	tmpDir := t.TempDir()

	// Test valid directory
	if err := ValidateCategoryDir(tmpDir); err != nil {
		t.Errorf("ValidateCategoryDir(%q) unexpected error: %v", tmpDir, err)
	}
}

func TestValidateCategoryDir_NotExists(t *testing.T) {
	err := ValidateCategoryDir("/nonexistent/directory")
	if err == nil {
		t.Error("expected error for nonexistent directory")
	}
	if !strings.Contains(err.Error(), "not found") {
		t.Errorf("error = %q, want to contain 'not found'", err.Error())
	}
}

func TestValidateCategoryDir_NotDirectory(t *testing.T) {
	tmpDir := t.TempDir()
	filePath := filepath.Join(tmpDir, "file.txt")
	if err := os.WriteFile(filePath, []byte("content"), 0644); err != nil {
		t.Fatalf("creating test file: %v", err)
	}

	err := ValidateCategoryDir(filePath)
	if err == nil {
		t.Error("expected error for file path")
	}
	if !strings.Contains(err.Error(), "not a directory") {
		t.Errorf("error = %q, want to contain 'not a directory'", err.Error())
	}
}
