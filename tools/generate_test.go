package main

import (
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
