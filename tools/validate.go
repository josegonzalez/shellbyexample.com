//go:build ignore

package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

var categoryFlag = flag.String("category", "", "Category directory to validate (e.g., examples/hello-world)")

func main() {
	flag.Usage = func() {
		fmt.Fprintln(os.Stderr, "Usage: go run tools/validate.go [options]")
		fmt.Fprintln(os.Stderr, "       go run tools/validate.go --category <directory>")
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Options:")
		flag.PrintDefaults()
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Examples:")
		fmt.Fprintln(os.Stderr, "  go run tools/validate.go")
		fmt.Fprintln(os.Stderr, "  go run tools/validate.go --category examples/hello-world")
	}
	flag.Parse()

	// If category specified, validate just that one
	if *categoryFlag != "" {
		errors := validateDirectory(*categoryFlag)

		// Find and report empty scripts in just this category
		emptyScripts := findEmptyScriptsInDirectory(*categoryFlag)
		if len(emptyScripts) > 0 {
			fmt.Printf("Found %d script(s) containing only shebang and comments:\n", len(emptyScripts))
			for _, path := range emptyScripts {
				fmt.Printf("  %s\n", path)
			}
			fmt.Println()
		}

		if len(errors) > 0 {
			fmt.Println("Validation errors found:")
			for _, err := range errors {
				fmt.Printf("  - %s\n", err)
			}
			os.Exit(1)
		}
		fmt.Printf("Category %s validated successfully.\n", *categoryFlag)
		return
	}

	// Otherwise, validate all (existing behavior)
	examplesDir := "examples"
	if flag.NArg() > 0 {
		examplesDir = flag.Arg(0)
	}

	errors := validate(examplesDir)

	// Find and report empty scripts
	emptyScripts := findEmptyScripts(examplesDir)
	if len(emptyScripts) > 0 {
		fmt.Printf("Found %d script(s) containing only shebang and comments:\n", len(emptyScripts))
		for _, path := range emptyScripts {
			fmt.Printf("  %s\n", path)
		}
		fmt.Println()
	}

	if len(errors) > 0 {
		fmt.Println("Validation errors found:")
		for _, err := range errors {
			fmt.Printf("  - %s\n", err)
		}
		os.Exit(1)
	}
	fmt.Println("All examples validated successfully.")
}

func validate(examplesDir string) []string {
	var errors []string

	entries, err := os.ReadDir(examplesDir)
	if err != nil {
		return []string{fmt.Sprintf("cannot read examples directory: %v", err)}
	}

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		dir := filepath.Join(examplesDir, entry.Name())
		dirErrors := validateDirectory(dir)
		errors = append(errors, dirErrors...)
	}

	return errors
}

func validateDirectory(dir string) []string {
	var errors []string
	dirName := filepath.Base(dir)

	// Pattern to match numbered files: NN-description.ext
	pattern := regexp.MustCompile(`^(\d+)-(.+)\.(sh|bash|output\.txt)$`)

	entries, err := os.ReadDir(dir)
	if err != nil {
		return []string{fmt.Sprintf("%s: cannot read directory: %v", dirName, err)}
	}

	// Collect script files and output files
	type fileInfo struct {
		number int
		base   string
		ext    string
	}

	var scripts []fileInfo
	outputs := make(map[string]bool) // "NN-base" -> exists

	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}

		name := entry.Name()
		matches := pattern.FindStringSubmatch(name)
		if matches == nil {
			// Check for legacy format (single file matching directory name)
			if name == dirName+".sh" || name == dirName+".bash" {
				// Legacy format, skip validation
				return nil
			}
			continue
		}

		num, _ := strconv.Atoi(matches[1])
		base := matches[2]
		ext := matches[3]

		if ext == "output.txt" {
			key := fmt.Sprintf("%02d-%s", num, base)
			outputs[key] = true
		} else {
			scripts = append(scripts, fileInfo{
				number: num,
				base:   base,
				ext:    ext,
			})
		}
	}

	// If no numbered scripts found, this might be legacy format
	if len(scripts) == 0 {
		return nil
	}

	// Sort scripts by number
	sort.Slice(scripts, func(i, j int) bool {
		return scripts[i].number < scripts[j].number
	})

	// Check 1: First file should be 01
	if scripts[0].number != 1 {
		errors = append(errors, fmt.Sprintf("%s: first file starts at %02d instead of 01", dirName, scripts[0].number))
	}

	// Check 2: No gaps in numbering
	seen := make(map[int]bool)
	for _, s := range scripts {
		seen[s.number] = true
	}

	maxNum := scripts[len(scripts)-1].number
	for i := 1; i <= maxNum; i++ {
		if !seen[i] {
			errors = append(errors, fmt.Sprintf("%s: missing number %02d (gap in sequence)", dirName, i))
		}
	}

	// Check 3: Each script should have a corresponding output file (warning only)
	for _, s := range scripts {
		key := fmt.Sprintf("%02d-%s", s.number, s.base)
		if !outputs[key] {
			// This is just a warning, not an error - some scripts may not have output
			// Uncomment below to make it an error:
			// errors = append(errors, fmt.Sprintf("%s: %02d-%s.%s has no output file", dirName, s.number, s.base, s.ext))
		}
	}

	// Check 4: No duplicate numbers with same base name
	type numBase struct {
		num  int
		base string
	}
	seenNumBase := make(map[numBase]string)
	for _, s := range scripts {
		key := numBase{s.number, s.base}
		if existing, ok := seenNumBase[key]; ok {
			errors = append(errors, fmt.Sprintf("%s: duplicate files for %02d-%s (%s and %s)", dirName, s.number, s.base, existing, s.ext))
		} else {
			seenNumBase[key] = s.ext
		}
	}

	// Check 5: Validate shebang in scripts
	for _, s := range scripts {
		scriptPath := filepath.Join(dir, fmt.Sprintf("%02d-%s.%s", s.number, s.base, s.ext))
		if err := validateShebang(scriptPath, s.ext); err != nil {
			errors = append(errors, fmt.Sprintf("%s: %v", dirName, err))
		}
	}

	return errors
}

func validateShebang(path string, ext string) error {
	content, err := os.ReadFile(path)
	if err != nil {
		return fmt.Errorf("%s: cannot read file: %v", filepath.Base(path), err)
	}

	lines := strings.SplitN(string(content), "\n", 2)
	if len(lines) == 0 || len(lines[0]) == 0 {
		return fmt.Errorf("%s: empty file", filepath.Base(path))
	}

	shebang := lines[0]
	if !strings.HasPrefix(shebang, "#!") {
		return fmt.Errorf("%s: missing shebang", filepath.Base(path))
	}

	// Check that .bash files use bash shebang
	if ext == "bash" {
		if !strings.Contains(shebang, "bash") {
			return fmt.Errorf("%s: .bash file should have bash shebang, got: %s", filepath.Base(path), shebang)
		}
	}

	return nil
}

func findEmptyScripts(examplesDir string) []string {
	var emptyScripts []string

	err := filepath.Walk(examplesDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if info.IsDir() {
			return nil
		}

		ext := filepath.Ext(path)
		if ext != ".sh" && ext != ".bash" {
			return nil
		}

		if isEmptyScript(path) {
			emptyScripts = append(emptyScripts, path)
		}

		return nil
	})

	if err != nil {
		fmt.Fprintf(os.Stderr, "Error walking directory: %v\n", err)
	}

	return emptyScripts
}

func findEmptyScriptsInDirectory(dir string) []string {
	var emptyScripts []string

	entries, err := os.ReadDir(dir)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading directory: %v\n", err)
		return emptyScripts
	}

	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}

		ext := filepath.Ext(entry.Name())
		if ext != ".sh" && ext != ".bash" {
			continue
		}

		path := filepath.Join(dir, entry.Name())
		if isEmptyScript(path) {
			emptyScripts = append(emptyScripts, path)
		}
	}

	return emptyScripts
}

// isEmptyScript returns true if the file contains only:
// - A shebang line (first line starting with #!)
// - Comment lines (starting with #)
// - Empty/whitespace-only lines
func isEmptyScript(path string) bool {
	file, err := os.Open(path)
	if err != nil {
		return false
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	lineNum := 0

	for scanner.Scan() {
		line := scanner.Text()
		lineNum++

		trimmed := strings.TrimSpace(line)

		// Empty or whitespace-only line
		if trimmed == "" {
			continue
		}

		// First line should be a shebang
		if lineNum == 1 {
			if !strings.HasPrefix(trimmed, "#!") {
				return false
			}
			continue
		}

		// All other non-empty lines should be comments
		if !strings.HasPrefix(trimmed, "#") {
			return false
		}
	}

	// Must have at least a shebang line
	return lineNum >= 1
}
