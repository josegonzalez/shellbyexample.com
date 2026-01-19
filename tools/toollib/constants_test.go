package toollib

import "testing"

func TestNumberedScriptPattern(t *testing.T) {
	tests := []struct {
		input string
		match bool
	}{
		{"01-hello-world.sh", true},
		{"01-hello-world.bash", true},
		{"99-test.sh", true},
		{"00-zero.sh", true},
		{"1-missing-zero.sh", false},
		{"001-too-many-digits.sh", false},
		{"hello-world.sh", false},
		{"01-test.txt", false},
		{"01-test.output.txt", false},
		{"01.sh", false},
		{"", false},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := NumberedScriptPattern.MatchString(tt.input)
			if result != tt.match {
				t.Errorf("NumberedScriptPattern.MatchString(%q) = %v, want %v", tt.input, result, tt.match)
			}
		})
	}
}

func TestNumberedFilePathPattern(t *testing.T) {
	tests := []struct {
		input string
		match bool
	}{
		{"/examples/hello-world/01-hello.sh", true},
		{"examples/test/99-foo.bash", true},
		{"/01-test.sh", true},
		{"hello-world.sh", false},
		{"test.sh", false},
		{"/examples/1-test.sh", false},
		{"", false},
	}

	for _, tt := range tests {
		t.Run(tt.input, func(t *testing.T) {
			result := NumberedFilePathPattern.MatchString(tt.input)
			if result != tt.match {
				t.Errorf("NumberedFilePathPattern.MatchString(%q) = %v, want %v", tt.input, result, tt.match)
			}
		})
	}
}

func TestConstants(t *testing.T) {
	if ExamplesDir != "examples" {
		t.Errorf("ExamplesDir = %q, want %q", ExamplesDir, "examples")
	}
	if NetworkComment != "# network: required" {
		t.Errorf("NetworkComment = %q, want %q", NetworkComment, "# network: required")
	}
	if RunInDockerScript != "./tools/run-in-docker.sh" {
		t.Errorf("RunInDockerScript = %q, want %q", RunInDockerScript, "./tools/run-in-docker.sh")
	}
}
