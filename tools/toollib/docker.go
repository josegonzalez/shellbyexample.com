package toollib

import (
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

// ScriptNeedsNetwork checks if a script requires network access.
// It looks for the "# network: required" comment in the file.
func ScriptNeedsNetwork(scriptPath string) bool {
	content, err := os.ReadFile(scriptPath)
	if err != nil {
		return false
	}
	return strings.Contains(string(content), NetworkComment)
}

// RunScriptInDocker executes a script in Docker and returns the combined output.
func RunScriptInDocker(scriptPath string, needsNetwork bool) ([]byte, error) {
	args := []string{}
	if needsNetwork {
		args = append(args, "-n")
	}
	args = append(args, scriptPath)
	cmd := exec.Command(RunInDockerScript, args...)
	return cmd.CombinedOutput()
}

// OutputPathForScript computes the .output.txt path for a given script.
func OutputPathForScript(scriptPath string) string {
	ext := filepath.Ext(scriptPath)
	return strings.TrimSuffix(scriptPath, ext) + ".output.txt"
}
