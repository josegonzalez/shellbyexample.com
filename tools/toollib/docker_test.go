package toollib

import (
	"os"
	"path/filepath"
	"testing"
)

func TestScriptNeedsNetwork(t *testing.T) {
	tmpDir := t.TempDir()

	tests := []struct {
		name     string
		content  string
		expected bool
	}{
		{
			name:     "script with network required",
			content:  "#!/bin/sh\n# network: required\necho hello",
			expected: true,
		},
		{
			name:     "script without network",
			content:  "#!/bin/sh\necho hello",
			expected: false,
		},
		{
			name:     "network comment in middle",
			content:  "#!/bin/sh\n# Some docs\n# network: required\necho hello",
			expected: true,
		},
		{
			name:     "similar but not exact comment",
			content:  "#!/bin/sh\n# network: true\necho hello",
			expected: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			scriptPath := filepath.Join(tmpDir, tt.name+".sh")
			if err := os.WriteFile(scriptPath, []byte(tt.content), 0644); err != nil {
				t.Fatalf("writing test file: %v", err)
			}

			result := ScriptNeedsNetwork(scriptPath)
			if result != tt.expected {
				t.Errorf("ScriptNeedsNetwork() = %v, want %v", result, tt.expected)
			}
		})
	}
}

func TestScriptNeedsNetwork_NonexistentFile(t *testing.T) {
	result := ScriptNeedsNetwork("/nonexistent/path/script.sh")
	if result != false {
		t.Errorf("ScriptNeedsNetwork for nonexistent file = %v, want false", result)
	}
}

func TestOutputPathForScript(t *testing.T) {
	tests := []struct {
		input    string
		expected string
	}{
		{"examples/hello-world/01-hello.sh", "examples/hello-world/01-hello.output.txt"},
		{"examples/test/01-test.bash", "examples/test/01-test.output.txt"},
		{"/absolute/path/script.sh", "/absolute/path/script.output.txt"},
		{"script.sh", "script.output.txt"},
		{"path/to/01-foo-bar.bash", "path/to/01-foo-bar.output.txt"},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := OutputPathForScript(tt.input)
			if result != tt.expected {
				t.Errorf("OutputPathForScript(%q) = %q, want %q", tt.input, result, tt.expected)
			}
		})
	}
}

func TestRunScriptInDocker_CommandConstruction(t *testing.T) {
	// We can't easily test the actual Docker execution without Docker,
	// but we can verify the function exists and handles missing script gracefully
	// The function will fail because the script doesn't exist, but shouldn't panic
	_, err := RunScriptInDocker("/nonexistent/script.sh", false)
	if err == nil {
		t.Skip("Docker execution succeeded unexpectedly (Docker may be running)")
	}
	// Error is expected - the important thing is the function doesn't panic
}

func TestRunScriptInDocker_WithNetwork(t *testing.T) {
	// Test that the network flag doesn't cause issues
	_, err := RunScriptInDocker("/nonexistent/script.sh", true)
	if err == nil {
		t.Skip("Docker execution succeeded unexpectedly (Docker may be running)")
	}
	// Error is expected - the important thing is the function doesn't panic
}
