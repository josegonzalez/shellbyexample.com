#!/bin/sh
# Trap preserves exit code:

exit_code_demo() {
  (
    trap 'echo "  Trap ran, exit code was: $?"' EXIT
    exit 42
  )
  echo "  Subshell exited with: $?"
}

echo "Exit code preservation:"
exit_code_demo
