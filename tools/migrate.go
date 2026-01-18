//go:build ignore

package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

// MigratedSubExample represents a sub-example to be written
type MigratedSubExample struct {
	Order    int
	Name     string // kebab-case name for filename
	IsBash   bool
	Docs     string
	Code     string
	Shebang  string
}

func main() {
	if err := runMigration(); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}

func runMigration() error {
	examplesDir := "examples"

	entries, err := os.ReadDir(examplesDir)
	if err != nil {
		return fmt.Errorf("reading examples directory: %w", err)
	}

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		exampleID := entry.Name()
		exampleDir := filepath.Join(examplesDir, exampleID)

		// Check if already migrated (has numbered files)
		if hasMigratedFiles(exampleDir) {
			fmt.Printf("Skipping %s (already migrated)\n", exampleID)
			continue
		}

		// Find legacy script
		legacyScript := findLegacyScript(exampleDir, exampleID)
		if legacyScript == "" {
			fmt.Printf("Skipping %s (no legacy script found)\n", exampleID)
			continue
		}

		fmt.Printf("Migrating %s...\n", exampleID)

		if err := migrateExample(exampleDir, legacyScript); err != nil {
			return fmt.Errorf("migrating %s: %w", exampleID, err)
		}
	}

	return nil
}

func hasMigratedFiles(dir string) bool {
	entries, err := os.ReadDir(dir)
	if err != nil {
		return false
	}

	subExampleRegex := regexp.MustCompile(`^\d{2}-.*\.(sh|bash)$`)
	for _, entry := range entries {
		if subExampleRegex.MatchString(entry.Name()) {
			return true
		}
	}
	return false
}

func findLegacyScript(dir, exampleID string) string {
	// Look for {exampleID}.sh first
	expectedPath := filepath.Join(dir, exampleID+".sh")
	if _, err := os.Stat(expectedPath); err == nil {
		return expectedPath
	}

	// Fall back to any .sh file
	entries, err := os.ReadDir(dir)
	if err != nil {
		return ""
	}

	for _, entry := range entries {
		if strings.HasSuffix(entry.Name(), ".sh") && !strings.HasPrefix(entry.Name(), ".") {
			// Skip numbered files
			if matched, _ := regexp.MatchString(`^\d{2}-`, entry.Name()); !matched {
				return filepath.Join(dir, entry.Name())
			}
		}
	}

	return ""
}

func migrateExample(dir, legacyPath string) error {
	content, err := os.ReadFile(legacyPath)
	if err != nil {
		return fmt.Errorf("reading legacy script: %w", err)
	}

	// Parse into sub-examples
	subExamples := parseIntoSubExamples(string(content))

	if len(subExamples) == 0 {
		return fmt.Errorf("no sub-examples found")
	}

	// Write sub-example files
	for _, sub := range subExamples {
		ext := "sh"
		if sub.IsBash {
			ext = "bash"
		}
		filename := fmt.Sprintf("%02d-%s.%s", sub.Order, sub.Name, ext)
		filePath := filepath.Join(dir, filename)

		content := formatSubExampleScript(sub)
		if err := os.WriteFile(filePath, []byte(content), 0644); err != nil {
			return fmt.Errorf("writing %s: %w", filename, err)
		}
		fmt.Printf("  Created %s\n", filename)
	}

	// Rename legacy script to .bak
	bakPath := legacyPath + ".bak"
	if err := os.Rename(legacyPath, bakPath); err != nil {
		return fmt.Errorf("backing up legacy script: %w", err)
	}
	fmt.Printf("  Backed up legacy script to %s\n", filepath.Base(bakPath))

	return nil
}

var bashStartRegex = regexp.MustCompile(`(?i)\[bash(\d)?(\s*\d*\+?)?\]`)
var bashEndRegex = regexp.MustCompile(`(?i)\[/bash(\d)?\]`)

func parseIntoSubExamples(content string) []MigratedSubExample {
	lines := strings.Split(content, "\n")
	var subExamples []MigratedSubExample
	var currentDocs []string
	var currentCode []string
	var shebang string
	order := 1
	inBashSection := false
	firstSegment := true
	isBashScript := false

	for i, line := range lines {
		trimmed := strings.TrimSpace(line)

		// Handle shebang
		if i == 0 && strings.HasPrefix(line, "#!") {
			shebang = line
			if strings.Contains(line, "bash") {
				isBashScript = true
			}
			continue
		}

		// Check for documentation line (: # syntax)
		if strings.HasPrefix(trimmed, ": #") {
			// If we have code, save current segment
			if len(currentCode) > 0 {
				sub := createSubExample(order, currentDocs, currentCode, shebang, inBashSection || isBashScript, firstSegment)
				if sub != nil {
					subExamples = append(subExamples, *sub)
					order++
					firstSegment = false
				}
				currentDocs = nil
				currentCode = nil
			}

			// Extract comment text
			comment := strings.TrimPrefix(trimmed, ": #")
			comment = strings.TrimPrefix(comment, " ")

			// Check for bash section markers
			if bashEndRegex.MatchString(comment) {
				inBashSection = false
				continue
			}
			if bashStartRegex.MatchString(comment) {
				// Save previous non-bash content
				if len(currentDocs) > 0 || len(currentCode) > 0 {
					sub := createSubExample(order, currentDocs, currentCode, shebang, false, firstSegment)
					if sub != nil {
						subExamples = append(subExamples, *sub)
						order++
						firstSegment = false
					}
					currentDocs = nil
					currentCode = nil
				}
				inBashSection = true
				// Remove marker from comment
				comment = bashStartRegex.ReplaceAllString(comment, "")
				comment = strings.TrimSpace(comment)
				if comment == "" {
					continue
				}
			}

			currentDocs = append(currentDocs, comment)
		} else {
			// Skip shellcheck directives
			if strings.HasPrefix(trimmed, "# shellcheck") {
				continue
			}

			// This is code
			// For bash sections, strip the "# " prefix if present
			if inBashSection && strings.HasPrefix(line, "# ") {
				line = line[2:]
			}
			currentCode = append(currentCode, line)
		}
	}

	// Don't forget the last segment
	if len(currentDocs) > 0 || len(currentCode) > 0 {
		sub := createSubExample(order, currentDocs, currentCode, shebang, inBashSection || isBashScript, firstSegment)
		if sub != nil {
			subExamples = append(subExamples, *sub)
		}
	}

	return subExamples
}

func createSubExample(order int, docs, code []string, shebang string, isBash, isFirst bool) *MigratedSubExample {
	docsText := strings.TrimSpace(strings.Join(docs, "\n"))
	codeText := strings.TrimSpace(strings.Join(code, "\n"))

	// Skip empty segments
	if docsText == "" && codeText == "" {
		return nil
	}

	// Generate name from first meaningful doc line or code
	name := generateSubExampleName(docsText, codeText, order)

	// Determine shebang for this sub-example
	subShebang := shebang
	if subShebang == "" {
		if isBash {
			subShebang = "#!/bin/bash"
		} else {
			subShebang = "#!/bin/sh"
		}
	} else if isBash && !strings.Contains(shebang, "bash") {
		// Override shebang for bash sections
		subShebang = "#!/bin/bash"
	}

	return &MigratedSubExample{
		Order:   order,
		Name:    name,
		IsBash:  isBash,
		Docs:    docsText,
		Code:    codeText,
		Shebang: subShebang,
	}
}

func generateSubExampleName(docs, code string, order int) string {
	// Try to extract a meaningful name from docs
	if docs != "" {
		// Use first line of docs
		firstLine := strings.Split(docs, "\n")[0]
		// Clean it up
		name := cleanNameFromText(firstLine)
		if name != "" {
			return name
		}
	}

	// Try to extract from code
	if code != "" {
		firstLine := strings.Split(code, "\n")[0]
		name := cleanNameFromText(firstLine)
		if name != "" {
			return name
		}
	}

	// Fallback
	return fmt.Sprintf("example-%d", order)
}

func cleanNameFromText(text string) string {
	// Remove common prefixes
	text = strings.TrimPrefix(text, "The ")
	text = strings.TrimPrefix(text, "This ")
	text = strings.TrimPrefix(text, "Our ")
	text = strings.TrimPrefix(text, "A ")
	text = strings.TrimPrefix(text, "An ")

	// Take first few words
	words := strings.Fields(text)
	if len(words) == 0 {
		return ""
	}

	// Take up to 4 words
	if len(words) > 4 {
		words = words[:4]
	}

	// Join and convert to kebab-case
	name := strings.ToLower(strings.Join(words, "-"))

	// Remove non-alphanumeric characters except hyphens
	var cleaned strings.Builder
	for _, r := range name {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') || r == '-' {
			cleaned.WriteRune(r)
		}
	}

	result := cleaned.String()

	// Clean up multiple hyphens
	for strings.Contains(result, "--") {
		result = strings.ReplaceAll(result, "--", "-")
	}

	result = strings.Trim(result, "-")

	// Limit length
	if len(result) > 30 {
		result = result[:30]
		result = strings.TrimRight(result, "-")
	}

	return result
}

func formatSubExampleScript(sub MigratedSubExample) string {
	var sb strings.Builder

	// Write shebang
	sb.WriteString(sub.Shebang)
	sb.WriteString("\n")

	// Write docs as # comments
	if sub.Docs != "" {
		for _, line := range strings.Split(sub.Docs, "\n") {
			if line == "" {
				sb.WriteString("#\n")
			} else {
				sb.WriteString("# ")
				sb.WriteString(line)
				sb.WriteString("\n")
			}
		}
		sb.WriteString("\n")
	}

	// Write code
	sb.WriteString(sub.Code)
	sb.WriteString("\n")

	return sb.String()
}
