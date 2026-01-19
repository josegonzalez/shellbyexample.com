package toollib

import (
	"fmt"
	"os"
	"path/filepath"
)

// FindAllScripts finds all numbered scripts in the examples directory.
func FindAllScripts() ([]string, error) {
	entries, err := os.ReadDir(ExamplesDir)
	if err != nil {
		return nil, fmt.Errorf("reading examples directory: %w", err)
	}

	var scripts []string
	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		dir := filepath.Join(ExamplesDir, entry.Name())
		categoryScripts, err := FindCategoryScripts(dir)
		if err != nil {
			continue
		}
		scripts = append(scripts, categoryScripts...)
	}

	return scripts, nil
}

// FindCategoryScripts finds all numbered scripts in a specific category directory.
func FindCategoryScripts(dir string) ([]string, error) {
	files, err := os.ReadDir(dir)
	if err != nil {
		return nil, fmt.Errorf("reading directory %s: %w", dir, err)
	}

	var scripts []string
	for _, file := range files {
		if file.IsDir() {
			continue
		}
		if NumberedScriptPattern.MatchString(file.Name()) {
			scripts = append(scripts, filepath.Join(dir, file.Name()))
		}
	}

	return scripts, nil
}

// ValidateCategoryDir validates that a directory exists and is indeed a directory.
func ValidateCategoryDir(dir string) error {
	info, err := os.Stat(dir)
	if err != nil {
		return fmt.Errorf("directory not found: %s", dir)
	}
	if !info.IsDir() {
		return fmt.Errorf("not a directory: %s", dir)
	}
	return nil
}
