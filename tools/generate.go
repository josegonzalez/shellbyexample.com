package main

import (
	"bytes"
	"fmt"
	"html/template"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
	"strings"

	"github.com/alecthomas/chroma/v2"
	"github.com/alecthomas/chroma/v2/formatters/html"
	"github.com/alecthomas/chroma/v2/lexers"
	"github.com/alecthomas/chroma/v2/styles"
	"github.com/gomarkdown/markdown"
	"github.com/gomarkdown/markdown/parser"
)

// Segment represents a documentation/code pair (old format)
type Segment struct {
	Docs          template.HTML
	DocsText      string
	Code          template.HTML
	CodeText      string
	IsBash        bool   // Whether this segment is bash-specific
	BashLabel     string // Label like "Bash", "Bash 4+", "Bash 5+"
	ShowBashLabel bool   // True only for first segment in consecutive bash group
}

// SubExample represents a single sub-example script (new format)
type SubExample struct {
	Order      int
	Name       string        // Derived from filename (e.g., "Hello World" from "01-hello-world.sh")
	Filename   string        // Original filename
	Code       template.HTML // Syntax highlighted
	CodeText   string        // Raw code for clipboard
	Output     template.HTML // Formatted output
	OutputText string        // Raw output
	IsBash     bool          // Based on .bash extension
	Docs       template.HTML // Rendered markdown documentation
	DocsText   string        // Raw documentation text
}

// Example represents a complete example
type Example struct {
	ID          string
	Name        string
	Segments    []Segment    // Old format
	SubExamples []SubExample // New format
	Next        *Example
	Prev        *Example
	IsBash      bool
	HasBashMix  bool // Mix of POSIX and Bash sub-examples
}

// IndexEntry for the index page
type IndexEntry struct {
	ID     string
	Name   string
	IsBash bool
}

// Config holds configuration for the site generator
type Config struct {
	BaseDir string // Base directory for reading examples, templates
	OutDir  string // Output directory (public/)
}

var (
	chromaFormatter *html.Formatter
	chromaStyle     *chroma.Style
)

func init() {
	chromaFormatter = html.New(html.WithClasses(true), html.TabWidth(4))
	chromaStyle = styles.Get("github")
}

func main() {
	cfg := Config{BaseDir: ".", OutDir: "public"}
	if err := run(cfg); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}

func run(cfg Config) error {
	// Read examples list
	examplesFile, err := os.ReadFile(filepath.Join(cfg.BaseDir, "examples.txt"))
	if err != nil {
		return fmt.Errorf("reading examples.txt: %w", err)
	}

	// Parse example IDs
	var exampleIDs []string
	for _, line := range strings.Split(string(examplesFile), "\n") {
		line = strings.TrimSpace(line)
		if line != "" && !strings.HasPrefix(line, "#") {
			exampleIDs = append(exampleIDs, line)
		}
	}

	// Load templates
	exampleTmpl, err := template.ParseFiles(filepath.Join(cfg.BaseDir, "templates/example.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing example template: %w", err)
	}
	indexTmpl, err := template.ParseFiles(filepath.Join(cfg.BaseDir, "templates/index.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing index template: %w", err)
	}

	// Parse all examples
	var examples []*Example
	for _, id := range exampleIDs {
		ex, err := parseExample(cfg.BaseDir, id)
		if err != nil {
			return fmt.Errorf("parsing example %s: %w", id, err)
		}
		examples = append(examples, ex)
	}

	// Link prev/next
	for i := range examples {
		if i > 0 {
			examples[i].Prev = examples[i-1]
		}
		if i < len(examples)-1 {
			examples[i].Next = examples[i+1]
		}
	}

	// Ensure output directory exists
	if err := os.MkdirAll(cfg.OutDir, 0755); err != nil {
		return fmt.Errorf("creating output directory: %w", err)
	}

	// Generate example pages
	for _, ex := range examples {
		var buf bytes.Buffer
		err := exampleTmpl.Execute(&buf, ex)
		if err != nil {
			return fmt.Errorf("rendering example %s: %w", ex.ID, err)
		}
		outPath := filepath.Join(cfg.OutDir, ex.ID+".html")
		err = os.WriteFile(outPath, buf.Bytes(), 0644)
		if err != nil {
			return fmt.Errorf("writing %s: %w", outPath, err)
		}
		fmt.Printf("Generated %s\n", outPath)
	}

	// Generate index page
	var indexEntries []IndexEntry
	for _, ex := range examples {
		indexEntries = append(indexEntries, IndexEntry{
			ID:     ex.ID,
			Name:   ex.Name,
			IsBash: ex.IsBash,
		})
	}
	var buf bytes.Buffer
	err = indexTmpl.Execute(&buf, indexEntries)
	if err != nil {
		return fmt.Errorf("rendering index: %w", err)
	}
	err = os.WriteFile(filepath.Join(cfg.OutDir, "index.html"), buf.Bytes(), 0644)
	if err != nil {
		return fmt.Errorf("writing index.html: %w", err)
	}
	fmt.Println("Generated public/index.html")

	// Copy CSS
	cssContent, err := os.ReadFile(filepath.Join(cfg.BaseDir, "templates/site.css"))
	if err != nil {
		return fmt.Errorf("reading site.css: %w", err)
	}

	// Generate Chroma CSS
	var chromaCSS bytes.Buffer
	chromaFormatter.WriteCSS(&chromaCSS, chromaStyle)

	// Combine CSS
	finalCSS := string(cssContent) + "\n/* Chroma syntax highlighting */\n" + chromaCSS.String()
	err = os.WriteFile(filepath.Join(cfg.OutDir, "site.css"), []byte(finalCSS), 0644)
	if err != nil {
		return fmt.Errorf("writing site.css: %w", err)
	}
	fmt.Println("Generated public/site.css")

	// Copy clipboard.js if it exists
	clipboardPath := filepath.Join(cfg.BaseDir, "templates/clipboard.js")
	if clipboardContent, err := os.ReadFile(clipboardPath); err == nil {
		err = os.WriteFile(filepath.Join(cfg.OutDir, "clipboard.js"), clipboardContent, 0644)
		if err != nil {
			return fmt.Errorf("writing clipboard.js: %w", err)
		}
		fmt.Println("Generated public/clipboard.js")
	}

	return nil
}

// subExampleFileRegex matches files like "01-hello-world.sh" or "02-echo-basics.bash"
var subExampleFileRegex = regexp.MustCompile(`^(\d{2})-(.+)\.(sh|bash)$`)

func parseExample(baseDir, id string) (*Example, error) {
	dir := filepath.Join(baseDir, "examples", id)
	entries, err := os.ReadDir(dir)
	if err != nil {
		return nil, fmt.Errorf("reading directory: %w", err)
	}

	// Check if this is new format (has numbered sub-example files) or old format
	var subExampleFiles []os.DirEntry
	var legacyScriptPath string

	for _, entry := range entries {
		name := entry.Name()
		if subExampleFileRegex.MatchString(name) {
			subExampleFiles = append(subExampleFiles, entry)
		} else if strings.HasSuffix(name, ".sh") && !strings.HasPrefix(name, ".") {
			legacyScriptPath = filepath.Join(dir, name)
		}
	}

	// Convert ID to name
	name := idToName(id)

	// Use new format if sub-example files exist
	if len(subExampleFiles) > 0 {
		return parseExampleNewFormat(dir, id, name, subExampleFiles)
	}

	// Fall back to legacy format
	if legacyScriptPath == "" {
		return nil, fmt.Errorf("no .sh file found in %s", dir)
	}

	return parseExampleLegacy(legacyScriptPath, id, name)
}

func parseExampleNewFormat(dir, id, name string, files []os.DirEntry) (*Example, error) {
	var subExamples []SubExample
	hasBash := false
	hasPosix := false

	for _, entry := range files {
		filename := entry.Name()
		subEx, err := parseSubExample(dir, filename)
		if err != nil {
			return nil, fmt.Errorf("parsing sub-example %s: %w", filename, err)
		}
		subExamples = append(subExamples, subEx)

		if subEx.IsBash {
			hasBash = true
		} else {
			hasPosix = true
		}
	}

	// Sort by order
	sort.Slice(subExamples, func(i, j int) bool {
		return subExamples[i].Order < subExamples[j].Order
	})

	return &Example{
		ID:          id,
		Name:        name,
		SubExamples: subExamples,
		IsBash:      hasBash && !hasPosix, // Only IsBash if all are bash
		HasBashMix:  hasBash && hasPosix,
	}, nil
}

func parseSubExample(dir, filename string) (SubExample, error) {
	matches := subExampleFileRegex.FindStringSubmatch(filename)
	if len(matches) != 4 {
		return SubExample{}, fmt.Errorf("invalid sub-example filename: %s", filename)
	}

	order, _ := strconv.Atoi(matches[1])
	descPart := matches[2]
	ext := matches[3]

	// Convert description to title (e.g., "hello-world" -> "Hello World")
	subName := idToName(descPart)

	// Determine if bash
	isBash := ext == "bash"

	// Read the script file
	scriptPath := filepath.Join(dir, filename)
	content, err := os.ReadFile(scriptPath)
	if err != nil {
		return SubExample{}, fmt.Errorf("reading script: %w", err)
	}

	// Extract documentation and code
	docs, code := extractDocsAndCode(string(content))

	// Try to load output file
	outputPath := filepath.Join(dir, strings.TrimSuffix(filename, "."+ext)+".output.txt")
	var outputText string
	if outputContent, err := os.ReadFile(outputPath); err == nil {
		outputText = strings.TrimRight(string(outputContent), "\n")
	}

	// Render markdown for docs
	var docsHTML template.HTML
	if docs != "" {
		extensions := parser.CommonExtensions | parser.AutoHeadingIDs
		p := parser.NewWithExtensions(extensions)
		html := markdown.ToHTML([]byte(docs), p, nil)
		docsHTML = template.HTML(html)
	}

	// Syntax highlight code
	var codeHTML template.HTML
	if code != "" {
		highlighted, err := highlightCode(code, "bash")
		if err != nil {
			codeHTML = template.HTML("<pre><code>" + template.HTMLEscapeString(code) + "</code></pre>")
		} else {
			codeHTML = template.HTML(highlighted)
		}
	}

	// Format output (escape HTML)
	var outputHTML template.HTML
	if outputText != "" {
		outputHTML = template.HTML(template.HTMLEscapeString(outputText))
	}

	return SubExample{
		Order:      order,
		Name:       subName,
		Filename:   filename,
		Code:       codeHTML,
		CodeText:   code,
		Output:     outputHTML,
		OutputText: outputText,
		IsBash:     isBash,
		Docs:       docsHTML,
		DocsText:   docs,
	}, nil
}

// extractDocsAndCode extracts leading # comments as documentation and the rest as code
// Documentation ends at the first empty line after comments
func extractDocsAndCode(content string) (docs, code string) {
	lines := strings.Split(content, "\n")
	var docLines []string
	var codeLines []string
	inDocs := false
	docsDone := false

	for i, line := range lines {
		trimmed := strings.TrimSpace(line)

		// Skip shebang - it goes to code
		if i == 0 && strings.HasPrefix(line, "#!") {
			codeLines = append(codeLines, line)
			continue
		}

		// If we haven't finished docs, look for # comments
		if !docsDone {
			if strings.HasPrefix(trimmed, "#") && !strings.HasPrefix(trimmed, "#!") {
				inDocs = true
				// Extract comment text (remove leading "# " or "#")
				comment := strings.TrimPrefix(trimmed, "#")
				comment = strings.TrimPrefix(comment, " ")
				// Filter out metadata comments that shouldn't appear in docs
				if strings.HasPrefix(comment, "network:") {
					continue
				}
				docLines = append(docLines, comment)
				continue
			} else if inDocs && trimmed == "" {
				// Empty line after doc comments ends the docs section
				docsDone = true
				// Don't add empty line to code yet, let the next iteration handle it
				continue
			} else if inDocs || trimmed != "" {
				// First non-comment, non-empty line after docs means docs are done
				docsDone = true
			}
		}

		// Everything after docs is code
		if docsDone || (!inDocs && trimmed != "") {
			docsDone = true
			codeLines = append(codeLines, line)
		}
	}

	docs = strings.TrimSpace(strings.Join(docLines, "\n"))
	code = strings.TrimRight(strings.Join(codeLines, "\n"), "\n\t ")

	return docs, code
}

func parseExampleLegacy(scriptPath, id, name string) (*Example, error) {
	content, err := os.ReadFile(scriptPath)
	if err != nil {
		return nil, fmt.Errorf("reading script: %w", err)
	}

	// Parse the script into segments
	lines := strings.Split(string(content), "\n")
	segments, isBash := parseSegments(lines)

	// Mark only first segment in each consecutive bash group to show label
	for i := range segments {
		if segments[i].IsBash {
			if i == 0 || !segments[i-1].IsBash {
				segments[i].ShowBashLabel = true
			}
		}
	}

	return &Example{
		ID:       id,
		Name:     name,
		Segments: segments,
		IsBash:   isBash,
	}, nil
}

func parseSegments(lines []string) ([]Segment, bool) {
	var segments []Segment
	var docLines []string
	var codeLines []string
	isBash := false
	inCode := false
	inBashSection := false
	currentBashLabel := ""

	for i, line := range lines {
		// Check for shebang
		if i == 0 && strings.HasPrefix(line, "#!") {
			if strings.Contains(line, "bash") {
				isBash = true
			}
			// Include shebang in code only, not docs
			codeLines = append(codeLines, line)
			inCode = true
			continue
		}

		// Check if this is a documentation line (: # syntax)
		trimmed := strings.TrimSpace(line)
		if strings.HasPrefix(trimmed, ": #") {
			// If we were in code, save the segment
			if inCode && len(codeLines) > 0 {
				segments = append(segments, createSegmentWithBash(docLines, codeLines, inBashSection, currentBashLabel))
				docLines = nil
				codeLines = nil
			}
			inCode = false

			// Extract the comment text (remove leading ": #" and optional space)
			comment := strings.TrimPrefix(trimmed, ": #")
			comment = strings.TrimPrefix(comment, " ")

			// Check for bash section end marker
			if bashEndRegex.MatchString(comment) {
				inBashSection = false
				currentBashLabel = ""
				// Don't include the marker line in output
				continue
			}

			// Check for bash section start marker
			if match := bashStartRegex.FindString(comment); match != "" {
				inBashSection = true
				currentBashLabel = extractBashLabel(match)
				// Remove the marker from the comment text
				comment = bashStartRegex.ReplaceAllString(comment, "")
				comment = strings.TrimSpace(comment)
				// If the line only contained the marker, skip it
				if comment == "" {
					continue
				}
			}

			docLines = append(docLines, comment)
		} else {
			// This is code
			// Skip shellcheck directives
			if strings.HasPrefix(strings.TrimSpace(line), "# shellcheck") {
				continue
			}
			if !inCode && len(docLines) > 0 {
				// Starting code after docs
				inCode = true
			}
			inCode = true
			codeLines = append(codeLines, line)
		}
	}

	// Don't forget the last segment
	if len(docLines) > 0 || len(codeLines) > 0 {
		segments = append(segments, createSegmentWithBash(docLines, codeLines, inBashSection, currentBashLabel))
	}

	// Clean up: remove empty segments and trailing empty code
	var cleanSegments []Segment
	for _, seg := range segments {
		// Skip segments with no real content
		if seg.DocsText == "" && strings.TrimSpace(seg.CodeText) == "" {
			continue
		}
		cleanSegments = append(cleanSegments, seg)
	}

	return cleanSegments, isBash
}

// stripBashCommentPrefix removes leading "# " from code lines in bash sections.
func stripBashCommentPrefix(codeLines []string) []string {
	result := make([]string, len(codeLines))
	for i, line := range codeLines {
		if strings.HasPrefix(line, "# ") {
			result[i] = line[2:] // Remove "# " (2 characters)
		} else {
			result[i] = line
		}
	}
	return result
}

func createSegment(docLines, codeLines []string) Segment {
	return createSegmentWithBash(docLines, codeLines, false, "")
}

func createSegmentWithBash(docLines, codeLines []string, isBash bool, bashLabel string) Segment {
	docsText := strings.Join(docLines, "\n")

	// For bash sections, strip leading "# " from code lines
	if isBash {
		codeLines = stripBashCommentPrefix(codeLines)
	}

	codeText := strings.Join(codeLines, "\n")

	// Trim trailing whitespace from code
	codeText = strings.TrimRight(codeText, "\n\t ")

	// Render markdown for docs
	var docsHTML template.HTML
	if docsText != "" {
		extensions := parser.CommonExtensions | parser.AutoHeadingIDs
		p := parser.NewWithExtensions(extensions)
		html := markdown.ToHTML([]byte(docsText), p, nil)
		docsHTML = template.HTML(html)
	}

	// Syntax highlight code
	var codeHTML template.HTML
	if codeText != "" {
		highlighted, err := highlightCode(codeText, "bash")
		if err != nil {
			// Fallback to plain text
			codeHTML = template.HTML("<pre><code>" + template.HTMLEscapeString(codeText) + "</code></pre>")
		} else {
			codeHTML = template.HTML(highlighted)
		}
	}

	return Segment{
		Docs:      docsHTML,
		DocsText:  docsText,
		Code:      codeHTML,
		CodeText:  codeText,
		IsBash:    isBash,
		BashLabel: bashLabel,
	}
}

func highlightCode(code, lang string) (string, error) {
	lexer := lexers.Get(lang)
	if lexer == nil {
		lexer = lexers.Fallback
	}
	lexer = chroma.Coalesce(lexer)

	iterator, err := lexer.Tokenise(nil, code)
	if err != nil {
		return "", err
	}

	var buf bytes.Buffer
	err = chromaFormatter.Format(&buf, chromaStyle, iterator)
	if err != nil {
		return "", err
	}

	return buf.String(), nil
}

func idToName(id string) string {
	// Convert "hello-world" to "Hello World"
	words := strings.Split(id, "-")
	for i, word := range words {
		if len(word) > 0 {
			words[i] = strings.ToUpper(word[:1]) + word[1:]
		}
	}
	return strings.Join(words, " ")
}

// Bash section markers for inline bash sections within POSIX examples
var bashStartRegex = regexp.MustCompile(`(?i)\[bash(\d)?(\s*\d*\+?)?\]`)
var bashEndRegex = regexp.MustCompile(`(?i)\[/bash(\d)?\]`)

// extractBashLabel parses a bash marker and returns the display label
func extractBashLabel(marker string) string {
	marker = strings.ToLower(marker)

	// Check for version number patterns
	if strings.Contains(marker, "5") {
		return "Bash 5+"
	}
	if strings.Contains(marker, "4") {
		return "Bash 4+"
	}

	// Default generic bash
	return "Bash"
}
