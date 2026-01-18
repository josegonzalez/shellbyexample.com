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

func TestExtractDocsAndCode(t *testing.T) {
	tests := []struct {
		name         string
		input        string
		expectedDocs string
		expectedCode string
	}{
		{
			name: "simple script with docs",
			input: `#!/bin/sh
# This is documentation

echo "Hello"`,
			expectedDocs: "This is documentation",
			expectedCode: `#!/bin/sh
echo "Hello"`,
		},
		{
			name: "multiline docs",
			input: `#!/bin/sh
# First line
# Second line
# Third line

echo "code"`,
			expectedDocs: "First line\nSecond line\nThird line",
			expectedCode: `#!/bin/sh
echo "code"`,
		},
		{
			name: "no docs",
			input: `#!/bin/sh
echo "Hello"`,
			expectedDocs: "",
			expectedCode: `#!/bin/sh
echo "Hello"`,
		},
		{
			name: "shellcheck filtered",
			input: `#!/bin/sh
# Documentation here

# shellcheck disable=SC2003
echo "test"`,
			expectedDocs: "Documentation here",
			expectedCode: `#!/bin/sh
echo "test"`,
		},
		{
			name: "network metadata filtered",
			input: `#!/bin/sh
# Documentation
# network: true

echo "test"`,
			expectedDocs: "Documentation",
			expectedCode: `#!/bin/sh
echo "test"`,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			docs, code := extractDocsAndCode(tt.input)
			if docs != tt.expectedDocs {
				t.Errorf("docs = %q, want %q", docs, tt.expectedDocs)
			}
			if code != tt.expectedCode {
				t.Errorf("code = %q, want %q", code, tt.expectedCode)
			}
		})
	}
}

func TestParseExample(t *testing.T) {
	tests := []struct {
		name       string
		exampleID  string
		expectBash bool
		expectMix  bool
		expectErr  bool
	}{
		{
			name:       "valid POSIX example",
			exampleID:  "valid-example",
			expectBash: false,
			expectMix:  false,
			expectErr:  false,
		},
		{
			name:       "valid Bash example",
			exampleID:  "bash-example",
			expectBash: true,
			expectMix:  false,
			expectErr:  false,
		},
		{
			name:       "mixed POSIX and Bash",
			exampleID:  "bash-section-example",
			expectBash: false,
			expectMix:  true,
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
			if ex.HasBashMix != tt.expectMix {
				t.Errorf("HasBashMix = %v, want %v", ex.HasBashMix, tt.expectMix)
			}
			if len(ex.SubExamples) == 0 {
				t.Error("expected at least one sub-example")
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
			name:      "no sub-example files",
			exampleID: "empty-dir",
			errMsg:    "no sub-example files found",
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

func TestParseExample_WithMixedFormats(t *testing.T) {
	ex, err := parseExample("testdata", "bash-section-example")
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	// Should be marked as mixed (has both POSIX and Bash sub-examples)
	if !ex.HasBashMix {
		t.Error("expected HasBashMix to be true for example with both .sh and .bash files")
	}

	// Should not be marked as bash overall
	if ex.IsBash {
		t.Error("expected IsBash to be false for mixed example")
	}

	// Check sub-examples
	if len(ex.SubExamples) != 2 {
		t.Errorf("expected 2 sub-examples, got %d", len(ex.SubExamples))
	}

	// First should be POSIX, second should be Bash
	if ex.SubExamples[0].IsBash {
		t.Error("first sub-example should be POSIX")
	}
	if !ex.SubExamples[1].IsBash {
		t.Error("second sub-example should be Bash")
	}
}

func TestRun_WithMixedExample(t *testing.T) {
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
	scriptPath := filepath.Join(exampleDir, "01-test.sh")
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

func TestParseSubExample(t *testing.T) {
	tmpDir := t.TempDir()

	// Create a test sub-example file
	content := `#!/bin/sh
# This is a test
# with multiple lines

echo "hello"
`
	if err := os.WriteFile(filepath.Join(tmpDir, "01-test.sh"), []byte(content), 0644); err != nil {
		t.Fatalf("writing test file: %v", err)
	}

	subEx, err := parseSubExample(tmpDir, "01-test.sh")
	if err != nil {
		t.Fatalf("parseSubExample error: %v", err)
	}

	if subEx.Order != 1 {
		t.Errorf("Order = %d, want 1", subEx.Order)
	}
	if subEx.Name != "Test" {
		t.Errorf("Name = %q, want %q", subEx.Name, "Test")
	}
	if subEx.Filename != "01-test.sh" {
		t.Errorf("Filename = %q, want %q", subEx.Filename, "01-test.sh")
	}
	if subEx.IsBash {
		t.Error("IsBash should be false for .sh file")
	}
	if !strings.Contains(subEx.DocsText, "This is a test") {
		t.Errorf("DocsText should contain documentation: %q", subEx.DocsText)
	}
}

func TestParseSubExample_BashExtension(t *testing.T) {
	tmpDir := t.TempDir()

	content := `#!/bin/bash
# Bash script

declare -A arr
`
	if err := os.WriteFile(filepath.Join(tmpDir, "01-test.bash"), []byte(content), 0644); err != nil {
		t.Fatalf("writing test file: %v", err)
	}

	subEx, err := parseSubExample(tmpDir, "01-test.bash")
	if err != nil {
		t.Fatalf("parseSubExample error: %v", err)
	}

	if !subEx.IsBash {
		t.Error("IsBash should be true for .bash file")
	}
}

func TestParseSubExample_WithOutput(t *testing.T) {
	tmpDir := t.TempDir()

	// Create script and output files
	script := `#!/bin/sh
# Test

echo "hello"
`
	output := "hello\n"

	if err := os.WriteFile(filepath.Join(tmpDir, "01-test.sh"), []byte(script), 0644); err != nil {
		t.Fatalf("writing script: %v", err)
	}
	if err := os.WriteFile(filepath.Join(tmpDir, "01-test.output.txt"), []byte(output), 0644); err != nil {
		t.Fatalf("writing output: %v", err)
	}

	subEx, err := parseSubExample(tmpDir, "01-test.sh")
	if err != nil {
		t.Fatalf("parseSubExample error: %v", err)
	}

	if subEx.OutputText != "hello" {
		t.Errorf("OutputText = %q, want %q", subEx.OutputText, "hello")
	}
}

func TestParseSubExample_InvalidFilename(t *testing.T) {
	tmpDir := t.TempDir()

	// Create a file with invalid naming
	if err := os.WriteFile(filepath.Join(tmpDir, "test.sh"), []byte("#!/bin/sh"), 0644); err != nil {
		t.Fatalf("writing test file: %v", err)
	}

	_, err := parseSubExample(tmpDir, "test.sh")
	if err == nil {
		t.Error("expected error for invalid filename")
	}
	if !strings.Contains(err.Error(), "invalid sub-example filename") {
		t.Errorf("error = %q, want to contain 'invalid sub-example filename'", err.Error())
	}
}
