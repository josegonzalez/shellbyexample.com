// Package toollib provides shared utilities for shell-by-example tools.
package toollib

import "regexp"

// Directory and file constants
const (
	ExamplesDir       = "examples"
	NetworkComment    = "# network: required"
	RunInDockerScript = "./tools/run-in-docker.sh"
)

// NumberedScriptPattern matches numbered script files (e.g., 01-hello-world.sh)
var NumberedScriptPattern = regexp.MustCompile(`^\d{2}-.*\.(sh|bash)$`)

// NumberedFilePathPattern matches paths containing numbered scripts
var NumberedFilePathPattern = regexp.MustCompile(`/[0-9]{2}-`)
