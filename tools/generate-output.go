//go:build ignore

package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"runtime"

	"github.com/josegonzalez/shellbyexample.com/tools/toollib"
)

var concurrency = flag.Int("j", runtime.NumCPU(), "number of parallel jobs")
var runAll = flag.Bool("all", false, "generate output for all scripts")
var categoryFlag = flag.String("category", "", "Category directory to generate outputs for (e.g., examples/hello-world)")

func main() {
	flag.Usage = func() {
		fmt.Fprintln(os.Stderr, "Usage: go run tools/generate-output.go [options] <script> [script...]")
		fmt.Fprintln(os.Stderr, "       go run tools/generate-output.go --all [-j N]")
		fmt.Fprintln(os.Stderr, "       go run tools/generate-output.go --category <directory> [-j N]")
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Options:")
		flag.PrintDefaults()
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Examples:")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go examples/hello-world/01-hello-world.sh")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go --all")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go --all -j 4")
		fmt.Fprintln(os.Stderr, "  go run tools/generate-output.go --category examples/hello-world")
	}
	flag.Parse()

	if *runAll {
		if err := generateAll(*concurrency); err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
		return
	}

	if *categoryFlag != "" {
		if err := generateCategory(*categoryFlag, *concurrency); err != nil {
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
	needsNetwork := toollib.ScriptNeedsNetwork(scriptPath)

	// Determine output file path
	outputPath := toollib.OutputPathForScript(scriptPath)

	if verbose {
		fmt.Printf("Running %s...\n", scriptPath)
	}

	// Run the script in Docker
	output, err := toollib.RunScriptInDocker(scriptPath, needsNetwork)

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
	scripts, err := toollib.FindAllScripts()
	if err != nil {
		return err
	}

	if len(scripts) == 0 {
		fmt.Println("No sub-example scripts found.")
		return nil
	}

	return runGeneration(scripts, numWorkers, "")
}

func generateCategory(categoryDir string, numWorkers int) error {
	if err := toollib.ValidateCategoryDir(categoryDir); err != nil {
		return err
	}

	scripts, err := toollib.FindCategoryScripts(categoryDir)
	if err != nil {
		return err
	}

	if len(scripts) == 0 {
		fmt.Printf("No numbered scripts found in %s.\n", categoryDir)
		return nil
	}

	return runGeneration(scripts, numWorkers, categoryDir)
}

func runGeneration(scripts []string, numWorkers int, categoryDir string) error {
	total := len(scripts)
	if categoryDir != "" {
		fmt.Printf("Found %d scripts in %s to process with %d workers.\n\n", total, categoryDir, numWorkers)
	} else {
		fmt.Printf("Found %d scripts to process with %d workers.\n\n", total, numWorkers)
	}

	var completed int
	var errors []scriptResult
	var warnings []scriptResult

	pool := toollib.WorkerPool[scriptResult]{
		Jobs:       scripts,
		NumWorkers: numWorkers,
		ProcessFn:  func(script string) scriptResult { return generateOutput(script, false) },
	}

	pool.Run(func(result scriptResult) {
		completed++
		if result.err != nil {
			errors = append(errors, result)
		} else if result.warning != "" {
			warnings = append(warnings, result)
		}
		fmt.Printf("\rProcessing: %d/%d scripts (%d errors)", completed, total, len(errors))
	})
	fmt.Println() // Move to next line after progress

	// Print summary
	if categoryDir != "" {
		fmt.Printf("\nDone. Processed %d scripts in %s.\n", total, categoryDir)
	} else {
		fmt.Printf("\nDone. Processed %d scripts.\n", total)
	}

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
