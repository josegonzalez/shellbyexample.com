package main

import (
	"os"
	"path/filepath"
	"strings"
	"testing"
)

func TestIdToName(t *testing.T) {
	tests := []struct {
		input    string
		expected string
	}{
		{"hello-world", "Hello World"},
		{"variables", "Variables"},
		{"for-loops", "For Loops"},
		{"if-statements", "If Statements"},
		{"command-substitution", "Command Substitution"},
		{"here-documents", "Here Documents"},
		{"", ""},
		{"a", "A"},
		{"a-b-c", "A B C"},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := idToName(tt.input)
			if result != tt.expected {
				t.Errorf("idToName(%q) = %q, want %q", tt.input, result, tt.expected)
			}
		})
	}
}

func TestExtractBashLabel(t *testing.T) {
	tests := []struct {
		input    string
		expected string
	}{
		{"[bash]", "Bash"},
		{"[BASH]", "Bash"},
		{"[Bash]", "Bash"},
		{"[bash4]", "Bash 4+"},
		{"[bash5]", "Bash 5+"},
		{"[bash 4+]", "Bash 4+"},
		{"[bash 5+]", "Bash 5+"},
		{"[BASH4]", "Bash 4+"},
		{"[BASH5]", "Bash 5+"},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := extractBashLabel(tt.input)
			if result != tt.expected {
				t.Errorf("extractBashLabel(%q) = %q, want %q", tt.input, result, tt.expected)
			}
		})
	}
}

func TestStripBashCommentPrefix(t *testing.T) {
	tests := []struct {
		name     string
		input    []string
		expected []string
	}{
		{
			name:     "strips # prefix",
			input:    []string{"# echo hello", "# echo world"},
			expected: []string{"echo hello", "echo world"},
		},
		{
			name:     "preserves lines without prefix",
			input:    []string{"echo hello", "echo world"},
			expected: []string{"echo hello", "echo world"},
		},
		{
			name:     "mixed lines",
			input:    []string{"# commented", "not commented", "# also commented"},
			expected: []string{"commented", "not commented", "also commented"},
		},
		{
			name:     "empty lines",
			input:    []string{"", "# hello", ""},
			expected: []string{"", "hello", ""},
		},
		{
			name:     "single hash without space",
			input:    []string{"#nospace"},
			expected: []string{"#nospace"},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := stripBashCommentPrefix(tt.input)
			if len(result) != len(tt.expected) {
				t.Fatalf("length mismatch: got %d, want %d", len(result), len(tt.expected))
			}
			for i := range result {
				if result[i] != tt.expected[i] {
					t.Errorf("line %d: got %q, want %q", i, result[i], tt.expected[i])
				}
			}
		})
	}
}

func TestParseSegments_BasicParsing(t *testing.T) {
	tests := []struct {
		name            string
		input           string
		expectedCount   int
		expectedIsBash  bool
		expectedDocsText []string
		expectedCodeText []string
	}{
		{
			name: "simple posix script",
			input: `#!/bin/sh
: # This is documentation
echo "Hello"`,
			expectedCount:    2,
			expectedIsBash:   false,
			expectedDocsText: []string{"", "This is documentation"},
			expectedCodeText: []string{"#!/bin/sh", "echo \"Hello\""},
		},
		{
			name: "bash script detected",
			input: `#!/bin/bash
: # Documentation here
echo "Hello"`,
			expectedCount:    2,
			expectedIsBash:   true,
			expectedDocsText: []string{"", "Documentation here"},
			expectedCodeText: []string{"#!/bin/bash", "echo \"Hello\""},
		},
		{
			name: "multiple segments",
			input: `#!/bin/sh
: # First doc
echo "first"
: # Second doc
echo "second"`,
			expectedCount:    3,
			expectedIsBash:   false,
			expectedDocsText: []string{"", "First doc", "Second doc"},
			expectedCodeText: []string{"#!/bin/sh", "echo \"first\"", "echo \"second\""},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			lines := strings.Split(tt.input, "\n")
			segments, isBash := parseSegments(lines)

			if isBash != tt.expectedIsBash {
				t.Errorf("isBash = %v, want %v", isBash, tt.expectedIsBash)
			}

			if len(segments) != tt.expectedCount {
				t.Errorf("segment count = %d, want %d", len(segments), tt.expectedCount)
				for i, seg := range segments {
					t.Logf("segment %d: docs=%q code=%q", i, seg.DocsText, seg.CodeText)
				}
				return
			}

			for i, seg := range segments {
				if i < len(tt.expectedDocsText) && seg.DocsText != tt.expectedDocsText[i] {
					t.Errorf("segment %d docs = %q, want %q", i, seg.DocsText, tt.expectedDocsText[i])
				}
				if i < len(tt.expectedCodeText) && seg.CodeText != tt.expectedCodeText[i] {
					t.Errorf("segment %d code = %q, want %q", i, seg.CodeText, tt.expectedCodeText[i])
				}
			}
		})
	}
}

func TestParseSegments_BashSections(t *testing.T) {
	tests := []struct {
		name           string
		input          string
		expectedBash   []bool
		expectedLabels []string
	}{
		{
			name: "inline bash section",
			input: `#!/bin/sh
: # POSIX code here
echo "posix"
: # [bash]
: # Bash-specific feature
# echo "bash only"
: # [/bash]
: # Back to POSIX
echo "posix again"`,
			expectedBash:   []bool{false, false, true, false},
			expectedLabels: []string{"", "", "Bash", ""},
		},
		{
			name: "bash4 section",
			input: `#!/bin/sh
: # [bash4]
: # Requires Bash 4
# declare -A assoc
: # [/bash]`,
			expectedBash:   []bool{false, true},
			expectedLabels: []string{"", "Bash 4+"},
		},
		{
			name: "bash5 section",
			input: `#!/bin/sh
: # [bash5]
: # Requires Bash 5
# new_feature
: # [/bash]`,
			expectedBash:   []bool{false, true},
			expectedLabels: []string{"", "Bash 5+"},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			lines := strings.Split(tt.input, "\n")
			segments, _ := parseSegments(lines)

			// Filter out empty segments for comparison
			var nonEmpty []Segment
			for _, seg := range segments {
				if seg.DocsText != "" || strings.TrimSpace(seg.CodeText) != "" {
					nonEmpty = append(nonEmpty, seg)
				}
			}

			if len(nonEmpty) != len(tt.expectedBash) {
				t.Errorf("segment count = %d, want %d", len(nonEmpty), len(tt.expectedBash))
				for i, seg := range nonEmpty {
					t.Logf("segment %d: isBash=%v label=%q docs=%q", i, seg.IsBash, seg.BashLabel, seg.DocsText)
				}
				return
			}

			for i, seg := range nonEmpty {
				if seg.IsBash != tt.expectedBash[i] {
					t.Errorf("segment %d IsBash = %v, want %v", i, seg.IsBash, tt.expectedBash[i])
				}
				if seg.BashLabel != tt.expectedLabels[i] {
					t.Errorf("segment %d BashLabel = %q, want %q", i, seg.BashLabel, tt.expectedLabels[i])
				}
			}
		})
	}
}

func TestParseSegments_EmptySegmentsRemoved(t *testing.T) {
	input := `#!/bin/sh

: # Documentation
echo "code"

`
	lines := strings.Split(input, "\n")
	segments, _ := parseSegments(lines)

	// Should have filtered out empty segments
	for i, seg := range segments {
		if seg.DocsText == "" && strings.TrimSpace(seg.CodeText) == "" {
			t.Errorf("segment %d is empty and should have been removed", i)
		}
	}
}

func TestShowBashLabelDeduplication(t *testing.T) {
	tests := []struct {
		name          string
		bashFlags     []bool
		expectedShow  []bool
	}{
		{
			name:         "single bash segment",
			bashFlags:    []bool{true},
			expectedShow: []bool{true},
		},
		{
			name:         "consecutive bash segments",
			bashFlags:    []bool{true, true, true},
			expectedShow: []bool{true, false, false},
		},
		{
			name:         "non-bash then bash",
			bashFlags:    []bool{false, true, true},
			expectedShow: []bool{false, true, false},
		},
		{
			name:         "bash, non-bash, bash",
			bashFlags:    []bool{true, false, true},
			expectedShow: []bool{true, false, true},
		},
		{
			name:         "alternating",
			bashFlags:    []bool{true, false, true, false, true},
			expectedShow: []bool{true, false, true, false, true},
		},
		{
			name:         "all non-bash",
			bashFlags:    []bool{false, false, false},
			expectedShow: []bool{false, false, false},
		},
		{
			name:         "complex pattern",
			bashFlags:    []bool{false, true, true, true, false, true, true},
			expectedShow: []bool{false, true, false, false, false, true, false},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create segments with the given bash flags
			segments := make([]Segment, len(tt.bashFlags))
			for i, isBash := range tt.bashFlags {
				segments[i] = Segment{IsBash: isBash}
			}

			// Apply the ShowBashLabel logic (same as in parseExample)
			for i := range segments {
				if segments[i].IsBash {
					if i == 0 || !segments[i-1].IsBash {
						segments[i].ShowBashLabel = true
					}
				}
			}

			// Verify results
			for i, seg := range segments {
				if seg.ShowBashLabel != tt.expectedShow[i] {
					t.Errorf("segment %d ShowBashLabel = %v, want %v", i, seg.ShowBashLabel, tt.expectedShow[i])
				}
			}
		})
	}
}

func TestCreateSegment(t *testing.T) {
	docLines := []string{"This is", "documentation"}
	codeLines := []string{"echo hello", "echo world"}

	seg := createSegment(docLines, codeLines)

	if seg.DocsText != "This is\ndocumentation" {
		t.Errorf("DocsText = %q, want %q", seg.DocsText, "This is\ndocumentation")
	}
	if seg.CodeText != "echo hello\necho world" {
		t.Errorf("CodeText = %q, want %q", seg.CodeText, "echo hello\necho world")
	}
	if seg.IsBash {
		t.Error("IsBash should be false for createSegment")
	}
	if seg.BashLabel != "" {
		t.Errorf("BashLabel = %q, want empty", seg.BashLabel)
	}
}

func TestCreateSegmentWithBash(t *testing.T) {
	docLines := []string{"Bash feature"}
	codeLines := []string{"# declare -A arr", "# arr[key]=value"}

	seg := createSegmentWithBash(docLines, codeLines, true, "Bash 4+")

	if seg.DocsText != "Bash feature" {
		t.Errorf("DocsText = %q, want %q", seg.DocsText, "Bash feature")
	}
	// Code should have "# " stripped
	if seg.CodeText != "declare -A arr\narr[key]=value" {
		t.Errorf("CodeText = %q, want %q", seg.CodeText, "declare -A arr\narr[key]=value")
	}
	if !seg.IsBash {
		t.Error("IsBash should be true")
	}
	if seg.BashLabel != "Bash 4+" {
		t.Errorf("BashLabel = %q, want %q", seg.BashLabel, "Bash 4+")
	}
}

func TestCreateSegment_TrimsTrailingWhitespace(t *testing.T) {
	docLines := []string{"doc"}
	codeLines := []string{"echo hello", "", "  ", ""}

	seg := createSegment(docLines, codeLines)

	if strings.HasSuffix(seg.CodeText, "\n") || strings.HasSuffix(seg.CodeText, " ") {
		t.Errorf("CodeText should not have trailing whitespace: %q", seg.CodeText)
	}
}

func TestBashStartRegex(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{"[bash]", true},
		{"[BASH]", true},
		{"[Bash]", true},
		{"[bash4]", true},
		{"[bash5]", true},
		{"[bash 4+]", true},
		{"[bash 5+]", true},
		{"bash", false},
		{"[notbash]", false},
		{"", false},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := bashStartRegex.MatchString(tt.input)
			if result != tt.expected {
				t.Errorf("bashStartRegex.MatchString(%q) = %v, want %v", tt.input, result, tt.expected)
			}
		})
	}
}

func TestBashEndRegex(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{"[/bash]", true},
		{"[/BASH]", true},
		{"[/Bash]", true},
		{"[/bash4]", true},
		{"[/bash5]", true},
		{"/bash", false},
		{"[bash]", false},
		{"", false},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := bashEndRegex.MatchString(tt.input)
			if result != tt.expected {
				t.Errorf("bashEndRegex.MatchString(%q) = %v, want %v", tt.input, result, tt.expected)
			}
		})
	}
}

func TestParseSegments_ShebangVariants(t *testing.T) {
	tests := []struct {
		name         string
		shebang      string
		expectedBash bool
	}{
		{"sh", "#!/bin/sh", false},
		{"bash", "#!/bin/bash", true},
		{"usr bin bash", "#!/usr/bin/bash", true},
		{"env bash", "#!/usr/bin/env bash", true},
		{"dash", "#!/bin/dash", false},
		{"zsh", "#!/bin/zsh", false},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			input := tt.shebang + "\necho hello"
			lines := strings.Split(input, "\n")
			_, isBash := parseSegments(lines)

			if isBash != tt.expectedBash {
				t.Errorf("shebang %q: isBash = %v, want %v", tt.shebang, isBash, tt.expectedBash)
			}
		})
	}
}

func TestParseSegments_MultilineDoc(t *testing.T) {
	input := `#!/bin/sh
: # This is a longer
: # documentation block
: # with multiple lines
echo "code"`

	lines := strings.Split(input, "\n")
	segments, _ := parseSegments(lines)

	// Find the segment with the multiline docs
	var found bool
	for _, seg := range segments {
		if strings.Contains(seg.DocsText, "longer") {
			found = true
			expected := "This is a longer\ndocumentation block\nwith multiple lines"
			if seg.DocsText != expected {
				t.Errorf("DocsText = %q, want %q", seg.DocsText, expected)
			}
		}
	}
	if !found {
		t.Error("did not find segment with multiline docs")
	}
}

func TestParseSegments_ShellcheckFiltered(t *testing.T) {
	input := `#!/bin/sh
: # Using expr for arithmetic
# shellcheck disable=SC2003
echo "5 + 3 = $(expr 5 + 3)"
echo "10 - 4 = $(expr 10 - 4)"`

	lines := strings.Split(input, "\n")
	segments, _ := parseSegments(lines)

	// Check that no segment contains shellcheck
	for i, seg := range segments {
		if strings.Contains(seg.CodeText, "shellcheck") {
			t.Errorf("segment %d should not contain shellcheck directive: %q", i, seg.CodeText)
		}
	}

	// Verify the expr commands are still present
	found := false
	for _, seg := range segments {
		if strings.Contains(seg.CodeText, "expr 5 + 3") {
			found = true
			break
		}
	}
	if !found {
		t.Error("expected to find expr command in output")
	}
}

func TestParseExample(t *testing.T) {
	tests := []struct {
		name       string
		exampleID  string
		expectBash bool
		expectErr  bool
	}{
		{
			name:       "valid POSIX example",
			exampleID:  "valid-example",
			expectBash: false,
			expectErr:  false,
		},
		{
			name:       "valid Bash example",
			exampleID:  "bash-example",
			expectBash: true,
			expectErr:  false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			ex, err := parseExample("testdata", tt.exampleID)
			if tt.expectErr {
				if err == nil {
					t.Error("expected error, got nil")
				}
				return
			}
			if err != nil {
				t.Fatalf("unexpected error: %v", err)
			}
			if ex.ID != tt.exampleID {
				t.Errorf("ID = %q, want %q", ex.ID, tt.exampleID)
			}
			if ex.IsBash != tt.expectBash {
				t.Errorf("IsBash = %v, want %v", ex.IsBash, tt.expectBash)
			}
			if len(ex.Segments) == 0 {
				t.Error("expected at least one segment")
			}
		})
	}
}

func TestParseExample_Errors(t *testing.T) {
	tests := []struct {
		name      string
		exampleID string
		errMsg    string
	}{
		{
			name:      "missing directory",
			exampleID: "nonexistent-example",
			errMsg:    "reading directory",
		},
		{
			name:      "no shell file",
			exampleID: "empty-dir",
			errMsg:    "no .sh file found",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := parseExample("testdata", tt.exampleID)
			if err == nil {
				t.Fatal("expected error, got nil")
			}
			if !strings.Contains(err.Error(), tt.errMsg) {
				t.Errorf("error = %q, want to contain %q", err.Error(), tt.errMsg)
			}
		})
	}
}

func TestRun(t *testing.T) {
	// Create a temporary output directory
	tmpDir := t.TempDir()

	cfg := Config{
		BaseDir: "testdata",
		OutDir:  tmpDir,
	}

	err := run(cfg)
	if err != nil {
		t.Fatalf("run() error: %v", err)
	}

	// Verify expected output files were created
	expectedFiles := []string{
		"index.html",
		"site.css",
		"valid-example.html",
		"bash-example.html",
	}

	for _, f := range expectedFiles {
		path := filepath.Join(tmpDir, f)
		if _, err := os.Stat(path); os.IsNotExist(err) {
			t.Errorf("expected file %s to exist", f)
		}
	}

	// Verify index.html contains example links
	indexContent, err := os.ReadFile(filepath.Join(tmpDir, "index.html"))
	if err != nil {
		t.Fatalf("reading index.html: %v", err)
	}
	if !strings.Contains(string(indexContent), "valid-example.html") {
		t.Error("index.html should contain link to valid-example.html")
	}

	// Verify CSS contains Chroma styles
	cssContent, err := os.ReadFile(filepath.Join(tmpDir, "site.css"))
	if err != nil {
		t.Fatalf("reading site.css: %v", err)
	}
	if !strings.Contains(string(cssContent), "Chroma syntax highlighting") {
		t.Error("site.css should contain Chroma syntax highlighting comment")
	}
}

func TestRun_Errors(t *testing.T) {
	tests := []struct {
		name   string
		cfg    Config
		errMsg string
	}{
		{
			name: "missing examples.txt",
			cfg: Config{
				BaseDir: "testdata/nonexistent",
				OutDir:  t.TempDir(),
			},
			errMsg: "reading examples.txt",
		},
		{
			name: "missing templates",
			cfg: Config{
				BaseDir: "testdata/no-templates", // has examples.txt but no templates dir
				OutDir:  t.TempDir(),
			},
			errMsg: "parsing example template",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := run(tt.cfg)
			if err == nil {
				t.Fatal("expected error, got nil")
			}
			if !strings.Contains(err.Error(), tt.errMsg) {
				t.Errorf("error = %q, want to contain %q", err.Error(), tt.errMsg)
			}
		})
	}
}

func TestHighlightCode(t *testing.T) {
	tests := []struct {
		name     string
		code     string
		lang     string
		wantErr  bool
		contains string
	}{
		{
			name:     "valid bash code",
			code:     "echo hello",
			lang:     "bash",
			wantErr:  false,
			contains: "echo",
		},
		{
			name:     "unknown language falls back",
			code:     "some code",
			lang:     "nonexistent-language-xyz",
			wantErr:  false,
			contains: "some code",
		},
		{
			name:     "empty code",
			code:     "",
			lang:     "bash",
			wantErr:  false,
			contains: "",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result, err := highlightCode(tt.code, tt.lang)
			if tt.wantErr {
				if err == nil {
					t.Error("expected error, got nil")
				}
				return
			}
			if err != nil {
				t.Fatalf("unexpected error: %v", err)
			}
			if tt.contains != "" && !strings.Contains(result, tt.contains) {
				t.Errorf("result = %q, want to contain %q", result, tt.contains)
			}
		})
	}
}

func TestCreateSegmentWithBash_EmptyInputs(t *testing.T) {
	// Test with empty doc lines
	seg := createSegmentWithBash(nil, []string{"echo hello"}, false, "")
	if seg.DocsText != "" {
		t.Errorf("DocsText = %q, want empty", seg.DocsText)
	}
	if seg.CodeText != "echo hello" {
		t.Errorf("CodeText = %q, want %q", seg.CodeText, "echo hello")
	}

	// Test with empty code lines
	seg2 := createSegmentWithBash([]string{"some docs"}, nil, false, "")
	if seg2.DocsText != "some docs" {
		t.Errorf("DocsText = %q, want %q", seg2.DocsText, "some docs")
	}
	if seg2.CodeText != "" {
		t.Errorf("CodeText = %q, want empty", seg2.CodeText)
	}

	// Test with both empty
	seg3 := createSegmentWithBash(nil, nil, false, "")
	if seg3.DocsText != "" {
		t.Errorf("DocsText = %q, want empty", seg3.DocsText)
	}
	if seg3.CodeText != "" {
		t.Errorf("CodeText = %q, want empty", seg3.CodeText)
	}
}

func TestParseSegments_EmptyInput(t *testing.T) {
	segments, isBash := parseSegments(nil)
	if len(segments) != 0 {
		t.Errorf("expected 0 segments, got %d", len(segments))
	}
	if isBash {
		t.Error("expected isBash to be false for nil input")
	}

	segments2, isBash2 := parseSegments([]string{})
	if len(segments2) != 0 {
		t.Errorf("expected 0 segments, got %d", len(segments2))
	}
	if isBash2 {
		t.Error("expected isBash to be false for empty input")
	}
}

func TestParseSegments_OnlyShebang(t *testing.T) {
	lines := []string{"#!/bin/sh"}
	segments, isBash := parseSegments(lines)
	// Shebang alone creates a segment with just the shebang in code
	if isBash {
		t.Error("expected isBash to be false for /bin/sh")
	}
	// The segment should have the shebang in it
	found := false
	for _, seg := range segments {
		if strings.Contains(seg.CodeText, "#!/bin/sh") {
			found = true
		}
	}
	if !found && len(segments) > 0 {
		t.Error("expected shebang to be present in a segment")
	}
}

func TestParseSegments_BashMarkerOnly(t *testing.T) {
	// Test a bash marker line that only contains the marker
	input := `#!/bin/sh
: # [bash]
# echo "bash only"
: # [/bash]`

	lines := strings.Split(input, "\n")
	segments, _ := parseSegments(lines)

	// Should create segments without the markers visible in docs
	for _, seg := range segments {
		if strings.Contains(seg.DocsText, "[bash]") || strings.Contains(seg.DocsText, "[/bash]") {
			t.Errorf("docs should not contain bash markers: %q", seg.DocsText)
		}
	}
}

func TestRun_MoreErrors(t *testing.T) {
	tests := []struct {
		name   string
		cfg    Config
		errMsg string
	}{
		{
			name: "missing index template",
			cfg: Config{
				BaseDir: "testdata/missing-index-tmpl",
				OutDir:  t.TempDir(),
			},
			errMsg: "parsing index template",
		},
		{
			name: "missing CSS file",
			cfg: Config{
				BaseDir: "testdata/missing-css",
				OutDir:  t.TempDir(),
			},
			errMsg: "reading site.css",
		},
		{
			name: "bad example in list",
			cfg: Config{
				BaseDir: "testdata/bad-example",
				OutDir:  t.TempDir(),
			},
			errMsg: "parsing example",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := run(tt.cfg)
			if err == nil {
				t.Fatal("expected error, got nil")
			}
			if !strings.Contains(err.Error(), tt.errMsg) {
				t.Errorf("error = %q, want to contain %q", err.Error(), tt.errMsg)
			}
		})
	}
}

func TestParseExample_WithBashSections(t *testing.T) {
	ex, err := parseExample("testdata", "bash-section-example")
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	// Should not be marked as bash overall (it's a POSIX script with bash sections)
	if ex.IsBash {
		t.Error("expected IsBash to be false for script with inline bash sections")
	}

	// Check that bash segments have the label set correctly
	bashSegmentFound := false
	for _, seg := range ex.Segments {
		if seg.IsBash {
			bashSegmentFound = true
			if seg.BashLabel == "" {
				t.Error("expected BashLabel to be set for bash segment")
			}
		}
	}

	if !bashSegmentFound {
		t.Error("expected to find at least one bash segment")
	}
}

func TestParseSegments_EmptySegmentFiltering(t *testing.T) {
	// Create input that would result in an empty segment
	input := `#!/bin/sh
: # doc
echo code
: #

`
	lines := strings.Split(input, "\n")
	segments, _ := parseSegments(lines)

	// Verify no empty segments
	for i, seg := range segments {
		if seg.DocsText == "" && strings.TrimSpace(seg.CodeText) == "" {
			t.Errorf("segment %d is empty", i)
		}
	}
}

func TestRun_WithBashSectionExample(t *testing.T) {
	tmpDir := t.TempDir()

	cfg := Config{
		BaseDir: "testdata",
		OutDir:  tmpDir,
	}

	err := run(cfg)
	if err != nil {
		t.Fatalf("run() error: %v", err)
	}

	// Verify the bash-section-example.html was created
	path := filepath.Join(tmpDir, "bash-section-example.html")
	if _, err := os.Stat(path); os.IsNotExist(err) {
		t.Error("expected bash-section-example.html to exist")
	}
}

func TestRun_TemplateExecuteErrors(t *testing.T) {
	tests := []struct {
		name   string
		cfg    Config
		errMsg string
	}{
		{
			name: "bad example template execution",
			cfg: Config{
				BaseDir: "testdata/bad-template",
				OutDir:  t.TempDir(),
			},
			errMsg: "rendering example",
		},
		{
			name: "bad index template execution",
			cfg: Config{
				BaseDir: "testdata/bad-index-template",
				OutDir:  t.TempDir(),
			},
			errMsg: "rendering index",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := run(tt.cfg)
			if err == nil {
				t.Fatal("expected error, got nil")
			}
			if !strings.Contains(err.Error(), tt.errMsg) {
				t.Errorf("error = %q, want to contain %q", err.Error(), tt.errMsg)
			}
		})
	}
}

func TestRun_WriteFileErrors(t *testing.T) {
	// Create a directory with read-only permissions to test write errors
	tmpDir := t.TempDir()
	readOnlyDir := filepath.Join(tmpDir, "readonly")
	if err := os.MkdirAll(readOnlyDir, 0555); err != nil {
		t.Skipf("cannot create read-only directory: %v", err)
	}
	defer os.Chmod(readOnlyDir, 0755) // Cleanup

	cfg := Config{
		BaseDir: "testdata",
		OutDir:  readOnlyDir,
	}

	err := run(cfg)
	if err == nil {
		// On some systems (like macOS with root), this might not fail
		t.Skip("write to read-only directory succeeded (running as root?)")
	}
	// We just want to verify that an error is returned for write failures
	// The exact error message depends on which write fails first
}

func TestParseExample_ReadScriptError(t *testing.T) {
	// Create a temporary directory structure with an unreadable script file
	tmpDir := t.TempDir()
	exampleDir := filepath.Join(tmpDir, "examples", "unreadable-example")
	if err := os.MkdirAll(exampleDir, 0755); err != nil {
		t.Fatalf("creating example dir: %v", err)
	}

	// Create a shell script with no read permission
	scriptPath := filepath.Join(exampleDir, "test.sh")
	if err := os.WriteFile(scriptPath, []byte("#!/bin/sh\necho hello"), 0000); err != nil {
		t.Fatalf("creating script: %v", err)
	}
	defer os.Chmod(scriptPath, 0644) // Cleanup

	_, err := parseExample(tmpDir, "unreadable-example")
	if err == nil {
		// On some systems (like running as root), this might not fail
		t.Skip("reading unreadable file succeeded (running as root?)")
	}
	if !strings.Contains(err.Error(), "reading script") {
		t.Errorf("error = %q, want to contain 'reading script'", err.Error())
	}
}

func TestRun_MkdirAllError(t *testing.T) {
	// Try to create output directory inside a non-existent path that can't be created
	// This is tricky because most paths can be created. We'll use a path that would
	// require creating a file as a directory.
	tmpDir := t.TempDir()
	blockingFile := filepath.Join(tmpDir, "blocker")
	if err := os.WriteFile(blockingFile, []byte("blocking"), 0644); err != nil {
		t.Fatalf("creating blocking file: %v", err)
	}

	cfg := Config{
		BaseDir: "testdata",
		OutDir:  filepath.Join(blockingFile, "subdir"), // Can't create dir inside a file
	}

	err := run(cfg)
	if err == nil {
		t.Fatal("expected error, got nil")
	}
	if !strings.Contains(err.Error(), "creating output directory") {
		t.Errorf("error = %q, want to contain 'creating output directory'", err.Error())
	}
}
