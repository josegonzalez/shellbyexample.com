//go:build ignore

package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run tools/generate-output.go <script> [script...]")
		fmt.Println("       go run tools/generate-output.go --all")
		fmt.Println("")
		fmt.Println("Examples:")
		fmt.Println("  go run tools/generate-output.go examples/hello-world/01-hello-world.sh")
		fmt.Println("  go run tools/generate-output.go --all")
		os.Exit(1)
	}

	if os.Args[1] == "--all" {
		if err := generateAll(); err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
		return
	}

	for _, script := range os.Args[1:] {
		if err := generateOutput(script); err != nil {
			fmt.Fprintf(os.Stderr, "Error generating %s: %v\n", script, err)
		}
	}
}

func generateOutput(scriptPath string) error {
	// Validate script exists
	if _, err := os.Stat(scriptPath); err != nil {
		return fmt.Errorf("script not found: %s", scriptPath)
	}

	// Validate it's a numbered sub-example
	base := filepath.Base(scriptPath)
	if !regexp.MustCompile(`^\d{2}-`).MatchString(base) {
		return fmt.Errorf("not a numbered sub-example: %s", base)
	}

	// Determine output file path
	ext := filepath.Ext(scriptPath)
	outputPath := strings.TrimSuffix(scriptPath, ext) + ".output.txt"

	fmt.Printf("Running %s...\n", scriptPath)

	// Run the script in Docker
	cmd := exec.Command("./tools/run-in-docker.sh", scriptPath)
	output, err := cmd.CombinedOutput()

	// Write output regardless of error (script might have non-zero exit)
	if writeErr := os.WriteFile(outputPath, output, 0644); writeErr != nil {
		return fmt.Errorf("writing output: %w", writeErr)
	}

	if err != nil {
		// Script failed but we still wrote the output
		fmt.Printf("  Warning: script exited with error: %v\n", err)
	}

	fmt.Printf("  Created %s\n", outputPath)
	return nil
}

func generateAll() error {
	pattern := regexp.MustCompile(`^\d{2}-.*\.(sh|bash)$`)

	entries, err := os.ReadDir("examples")
	if err != nil {
		return fmt.Errorf("reading examples directory: %w", err)
	}

	var scripts []string
	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		dir := filepath.Join("examples", entry.Name())
		files, err := os.ReadDir(dir)
		if err != nil {
			continue
		}

		for _, file := range files {
			if file.IsDir() {
				continue
			}
			if pattern.MatchString(file.Name()) {
				scripts = append(scripts, filepath.Join(dir, file.Name()))
			}
		}
	}

	if len(scripts) == 0 {
		fmt.Println("No sub-example scripts found.")
		return nil
	}

	fmt.Printf("Found %d scripts to process.\n\n", len(scripts))

	for _, script := range scripts {
		if err := generateOutput(script); err != nil {
			fmt.Fprintf(os.Stderr, "  Error: %v\n", err)
		}
	}

	fmt.Printf("\nDone. Processed %d scripts.\n", len(scripts))
	return nil
}
