//go:build ignore

package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"runtime"
	"strings"
	"sync"
)

var concurrency = flag.Int("j", runtime.NumCPU(), "number of parallel jobs")
var runAll = flag.Bool("all", false, "generate output for all scripts")

func main() {
	flag.Usage = func() {
		fmt.Fprintln(os.Stderr, "Usage: go run tools/generate-output.go [options] <script> [script...]")
		fmt.Fprintln(os.Stderr, "       go run tools/generate-output.go --all [-j N]")
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Options:")
		flag.PrintDefaults()
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Examples:")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go examples/hello-world/01-hello-world.sh")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go --all")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go --all -j 4")
	}
	flag.Parse()

	if *runAll {
		if err := generateAll(*concurrency); err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
		return
	}

	if flag.NArg() < 1 {
		flag.Usage()
		os.Exit(1)
	}

	for _, script := range flag.Args() {
		result := generateOutput(script, true)
		if result.err != nil {
			fmt.Fprintf(os.Stderr, "Error generating %s: %v\n", script, result.err)
		}
	}
}

type scriptResult struct {
	script  string
	err     error
	warning string
}

func generateOutput(scriptPath string, verbose bool) scriptResult {
	result := scriptResult{script: scriptPath}

	// Validate script exists
	if _, err := os.Stat(scriptPath); err != nil {
		result.err = fmt.Errorf("script not found: %s", scriptPath)
		return result
	}

	// Validate it's a numbered sub-example
	base := filepath.Base(scriptPath)
	if !regexp.MustCompile(`^\d{2}-`).MatchString(base) {
		result.err = fmt.Errorf("not a numbered sub-example: %s", base)
		return result
	}

	// Check if script needs network access
	needsNetwork := false
	content, err := os.ReadFile(scriptPath)
	if err == nil && strings.Contains(string(content), "# network: required") {
		needsNetwork = true
	}

	// Determine output file path
	ext := filepath.Ext(scriptPath)
	outputPath := strings.TrimSuffix(scriptPath, ext) + ".output.txt"

	if verbose {
		fmt.Printf("Running %s...\n", scriptPath)
	}

	// Run the script in Docker
	args := []string{}
	if needsNetwork {
		args = append(args, "-n")
	}
	args = append(args, scriptPath)
	cmd := exec.Command("./tools/run-in-docker.sh", args...)
	output, err := cmd.CombinedOutput()

	// Write output regardless of error (script might have non-zero exit)
	if writeErr := os.WriteFile(outputPath, output, 0644); writeErr != nil {
		result.err = fmt.Errorf("writing output: %w", writeErr)
		return result
	}

	if err != nil {
		// Script failed but we still wrote the output
		result.warning = fmt.Sprintf("script exited with error: %v", err)
	}

	if verbose {
		if result.warning != "" {
			fmt.Printf("  Warning: %s\n", result.warning)
		}
		fmt.Printf("  Created %s\n", outputPath)
	}

	return result
}

func generateAll(numWorkers int) error {
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

	total := len(scripts)
	fmt.Printf("Found %d scripts to process with %d workers.\n\n", total, numWorkers)

	// Create channels for job distribution and result collection
	jobs := make(chan string, total)
	results := make(chan scriptResult, total)

	// Start workers
	var wg sync.WaitGroup
	for i := 0; i < numWorkers; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for script := range jobs {
				results <- generateOutput(script, false)
			}
		}()
	}

	// Send all jobs
	for _, script := range scripts {
		jobs <- script
	}
	close(jobs)

	// Close results channel when all workers complete
	go func() {
		wg.Wait()
		close(results)
	}()

	// Collect results with progress display
	var completed int
	var errors []scriptResult
	var warnings []scriptResult

	for result := range results {
		completed++
		if result.err != nil {
			errors = append(errors, result)
		} else if result.warning != "" {
			warnings = append(warnings, result)
		}
		fmt.Printf("\rProcessing: %d/%d scripts (%d errors)", completed, total, len(errors))
	}
	fmt.Println() // Move to next line after progress

	// Print summary
	fmt.Printf("\nDone. Processed %d scripts.\n", total)

	if len(warnings) > 0 {
		fmt.Printf("\nWarnings (%d):\n", len(warnings))
		for _, w := range warnings {
			fmt.Printf("  %s: %s\n", w.script, w.warning)
		}
	}

	if len(errors) > 0 {
		fmt.Printf("\nErrors (%d):\n", len(errors))
		for _, e := range errors {
			fmt.Printf("  %s: %v\n", e.script, e.err)
		}
	}

	return nil
}
