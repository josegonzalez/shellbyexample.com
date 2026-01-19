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
var runAll = flag.Bool("all", false, "test all example scripts")
var categoryFlag = flag.String("category", "", "Category directory to test (e.g., examples/hello-world)")

func main() {
	flag.Usage = func() {
		fmt.Fprintln(os.Stderr, "Usage: go run tools/test-examples.go [options] <script> [script...]")
		fmt.Fprintln(os.Stderr, "       go run tools/test-examples.go --all [-j N]")
		fmt.Fprintln(os.Stderr, "       go run tools/test-examples.go --category <directory> [-j N]")
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Options:")
		flag.PrintDefaults()
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Examples:")
		fmt.Fprintln(os.Stderr, "  go run tools/test-examples.go examples/hello-world/01-hello-world.sh")
		fmt.Fprintln(os.Stderr, "  go run tools/test-examples.go --all")
		fmt.Fprintln(os.Stderr, "  go run tools/test-examples.go --all -j 4")
		fmt.Fprintln(os.Stderr, "  go run tools/test-examples.go --category examples/hello-world")
	}
	flag.Parse()

	if *runAll {
		passed, failed := testAll(*concurrency)
		printSummary(passed, failed)
		if failed > 0 {
			os.Exit(1)
		}
		return
	}

	if *categoryFlag != "" {
		passed, failed := testCategory(*categoryFlag, *concurrency)
		printSummary(passed, failed)
		if failed > 0 {
			os.Exit(1)
		}
		return
	}

	if flag.NArg() < 1 {
		flag.Usage()
		os.Exit(1)
	}

	var passed, failed int
	for _, script := range flag.Args() {
		result := testScript(script)
		if result.passed {
			passed++
			fmt.Printf("Testing %s... OK\n", script)
		} else {
			failed++
			fmt.Printf("Testing %s... FAILED\n", script)
			if result.err != nil {
				fmt.Printf("  Error: %v\n", result.err)
			}
		}
	}

	printSummary(passed, failed)
	if failed > 0 {
		os.Exit(1)
	}
}

type testResult struct {
	script string
	passed bool
	err    error
}

func testScript(scriptPath string) testResult {
	result := testResult{script: scriptPath}

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

	// Run the script in Docker
	args := []string{}
	if needsNetwork {
		args = append(args, "-n")
	}
	args = append(args, scriptPath)
	cmd := exec.Command("./tools/run-in-docker.sh", args...)
	_, err = cmd.CombinedOutput()

	if err != nil {
		result.err = err
		return result
	}

	result.passed = true
	return result
}

func testAll(numWorkers int) (passed, failed int) {
	pattern := regexp.MustCompile(`^\d{2}-.*\.(sh|bash)$`)

	entries, err := os.ReadDir("examples")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading examples directory: %v\n", err)
		return 0, 1
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
		return 0, 0
	}

	return runTests(scripts, numWorkers)
}

func testCategory(categoryDir string, numWorkers int) (passed, failed int) {
	pattern := regexp.MustCompile(`^\d{2}-.*\.(sh|bash)$`)

	// Validate the directory exists
	info, err := os.Stat(categoryDir)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: category directory not found: %s\n", categoryDir)
		return 0, 1
	}
	if !info.IsDir() {
		fmt.Fprintf(os.Stderr, "Error: not a directory: %s\n", categoryDir)
		return 0, 1
	}

	files, err := os.ReadDir(categoryDir)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading category directory: %v\n", err)
		return 0, 1
	}

	var scripts []string
	for _, file := range files {
		if file.IsDir() {
			continue
		}
		if pattern.MatchString(file.Name()) {
			scripts = append(scripts, filepath.Join(categoryDir, file.Name()))
		}
	}

	if len(scripts) == 0 {
		fmt.Printf("No numbered scripts found in %s.\n", categoryDir)
		return 0, 0
	}

	return runTests(scripts, numWorkers)
}

func runTests(scripts []string, numWorkers int) (passed, failed int) {
	total := len(scripts)
	fmt.Printf("Found %d scripts to test with %d workers.\n\n", total, numWorkers)

	// Create channels for job distribution and result collection
	jobs := make(chan string, total)
	results := make(chan testResult, total)

	// Start workers
	var wg sync.WaitGroup
	for i := 0; i < numWorkers; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for script := range jobs {
				results <- testScript(script)
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
	var failures []testResult

	for result := range results {
		completed++
		if result.passed {
			passed++
		} else {
			failed++
			failures = append(failures, result)
		}
		fmt.Printf("\rTesting: %d/%d scripts (%d passed, %d failed)", completed, total, passed, failed)
	}
	fmt.Println() // Move to next line after progress

	// Print failures
	if len(failures) > 0 {
		fmt.Printf("\nFailed tests (%d):\n", len(failures))
		for _, f := range failures {
			fmt.Printf("  %s", f.script)
			if f.err != nil {
				fmt.Printf(": %v", f.err)
			}
			fmt.Println()
		}
	}

	return passed, failed
}

func printSummary(passed, failed int) {
	total := passed + failed
	fmt.Printf("\n%d passed, %d failed out of %d tests\n", passed, failed, total)
}
