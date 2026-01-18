#!/bin/sh

: # Every command returns an exit code (0-255).
: # By convention, 0 means success and non-zero
: # indicates an error. The special variable `$?`
: # holds the last command's exit code.

: # Successful command returns 0:

true
echo "Exit code of 'true': $?"

: # Failed command returns non-zero:

false
echo "Exit code of 'false': $?"

: # Common exit codes by convention:
: # 0 - Success
: # 1 - General errors
: # 2 - Misuse of shell command
: # 126 - Command not executable
: # 127 - Command not found
: # 128+N - Fatal error signal N

: # Check exit code with if statement:

if grep -q "root" /etc/passwd; then
  echo "Found root user (grep returned 0)"
else
  echo "No root user found"
fi

: # Using $? explicitly:

ls /nonexistent 2>/dev/null
status=$?
if [ "$status" -ne 0 ]; then
  echo "ls failed with exit code: $status"
fi

: # The `exit` command sets the script's exit code:

run_check() {
  if [ -f "/etc/passwd" ]; then
    return 0 # Success
  else
    return 1 # Failure
  fi
}

run_check
echo "run_check returned: $?"

: # Return codes in functions use `return`, not `exit`.
: # `exit` would terminate the entire script.

check_file() {
  [ -f "$1" ] # Return code is the test's result
}

check_file "/etc/passwd"
echo "Check /etc/passwd: $?"

check_file "/nonexistent"
echo "Check /nonexistent: $?"

: # Chain commands based on exit codes:

echo "Using && (run if previous succeeded):"
true && echo "  This runs because true succeeded"
false && echo "  This won't run"

echo "Using || (run if previous failed):"
false || echo "  This runs because false failed"
true || echo "  This won't run"

: # Combine && and || for simple conditionals:

test -d "/tmp" && echo "/tmp exists" || echo "/tmp missing"

: # Exit codes with pipes - $? gives last command's code:

echo "hello" | grep -q "world"
echo "Pipe exit code: $?"

: # [bash]
: # Bash provides PIPESTATUS array for all pipe exit codes:

# cat /nonexistent 2>/dev/null | grep "pattern" | wc -l
# echo "First command: ${PIPESTATUS[0]}"
# echo "Second command: ${PIPESTATUS[1]}"
# echo "Third command: ${PIPESTATUS[2]}"
: # [/bash]

: # Use `set -e` to exit on first error:

echo "Without set -e:"
(
  false
  echo "  This still runs"
)

echo "With set -e:"
(
  set -e
  true
  echo "  This runs"
  # false would cause exit here
)

: # Use `set -o pipefail` with `set -e` for pipe errors:

: # [bash]
: # This makes the script exit if any command in a
: # pipeline fails, not just the last one.
# set -eo pipefail
: # [/bash]

: # Custom exit codes for different error types:

ERR_INVALID_ARG=1
ERR_FILE_NOT_FOUND=2
ERR_PERMISSION=3

validate_arg() {
  case "$1" in
    start | stop) return 0 ;;
    *) return "$ERR_INVALID_ARG" ;;
  esac
}

validate_arg "invalid"
code=$?
case $code in
  0) echo "Valid argument" ;;
  "$ERR_INVALID_ARG") echo "Invalid argument (code $code)" ;;
esac

: # Trap EXIT for cleanup regardless of exit code:

cleanup_demo() {
  (
    trap 'echo "  Cleanup runs on exit"' EXIT
    echo "  Doing work..."
    # Even with errors, cleanup runs
  )
}
echo "Trap EXIT demo:"
cleanup_demo

: # Best practice: always check critical commands:

if ! command -v ls >/dev/null 2>&1; then
  echo "ls command not found" >&2
  exit 127
fi

echo "Script completed successfully"
