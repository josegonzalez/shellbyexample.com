package main

import (
	"bytes"
	"fmt"
	"html/template"
	"os"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/alecthomas/chroma/v2"
	"github.com/alecthomas/chroma/v2/formatters/html"
	"github.com/alecthomas/chroma/v2/lexers"
	"github.com/alecthomas/chroma/v2/styles"
	"github.com/gomarkdown/markdown"
	"github.com/gomarkdown/markdown/parser"
)

// Segment represents a documentation/code pair
type Segment struct {
	Docs          template.HTML
	DocsText      string
	Code          template.HTML
	CodeText      string
	IsBash        bool   // Whether this segment is bash-specific
	BashLabel     string // Label like "Bash", "Bash 4+", "Bash 5+"
	ShowBashLabel bool   // True only for first segment in consecutive bash group
}

// Example represents a complete example
type Example struct {
	ID       string
	Name     string
	Segments []Segment
	Next     *Example
	Prev     *Example
	IsBash   bool
}

// IndexEntry for the index page
type IndexEntry struct {
	ID     string
	Name   string
	IsBash bool
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
	// Read examples list
	examplesFile, err := os.ReadFile("examples.txt")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading examples.txt: %v\n", err)
		os.Exit(1)
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
	exampleTmpl := template.Must(template.ParseFiles("templates/example.tmpl"))
	indexTmpl := template.Must(template.ParseFiles("templates/index.tmpl"))

	// Parse all examples
	var examples []*Example
	for _, id := range exampleIDs {
		ex, err := parseExample(id)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error parsing example %s: %v\n", id, err)
			os.Exit(1)
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

	// Ensure public directory exists
	os.MkdirAll("public", 0755)

	// Generate example pages
	for _, ex := range examples {
		var buf bytes.Buffer
		err := exampleTmpl.Execute(&buf, ex)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error rendering example %s: %v\n", ex.ID, err)
			os.Exit(1)
		}
		outPath := filepath.Join("public", ex.ID+".html")
		err = os.WriteFile(outPath, buf.Bytes(), 0644)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error writing %s: %v\n", outPath, err)
			os.Exit(1)
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
		fmt.Fprintf(os.Stderr, "Error rendering index: %v\n", err)
		os.Exit(1)
	}
	err = os.WriteFile("public/index.html", buf.Bytes(), 0644)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error writing index.html: %v\n", err)
		os.Exit(1)
	}
	fmt.Println("Generated public/index.html")

	// Copy CSS
	cssContent, err := os.ReadFile("templates/site.css")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading site.css: %v\n", err)
		os.Exit(1)
	}

	// Generate Chroma CSS
	var chromaCSS bytes.Buffer
	chromaFormatter.WriteCSS(&chromaCSS, chromaStyle)

	// Combine CSS
	finalCSS := string(cssContent) + "\n/* Chroma syntax highlighting */\n" + chromaCSS.String()
	err = os.WriteFile("public/site.css", []byte(finalCSS), 0644)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error writing site.css: %v\n", err)
		os.Exit(1)
	}
	fmt.Println("Generated public/site.css")
}

func parseExample(id string) (*Example, error) {
	// Find the shell script file
	dir := filepath.Join("examples", id)
	entries, err := os.ReadDir(dir)
	if err != nil {
		return nil, fmt.Errorf("reading directory: %w", err)
	}

	var scriptPath string
	for _, entry := range entries {
		if strings.HasSuffix(entry.Name(), ".sh") {
			scriptPath = filepath.Join(dir, entry.Name())
			break
		}
	}
	if scriptPath == "" {
		return nil, fmt.Errorf("no .sh file found in %s", dir)
	}

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
			// Show label if this is the first segment OR previous wasn't bash
			if i == 0 || !segments[i-1].IsBash {
				segments[i].ShowBashLabel = true
			}
		}
	}

	// Convert ID to name
	name := idToName(id)

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

// bashLabelRegex matches Bash-specific indicators in comments
var bashLabelRegex = regexp.MustCompile(`(?i)\[bash\]|\(bash\)|bash-specific|bash only`)

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
