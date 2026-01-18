#!/bin/sh

: # The `trap` command lets you catch signals and
: # execute cleanup code when your script exits or
: # receives signals. It's essential for robust scripts.

: # Basic trap syntax: trap 'commands' SIGNAL

: # Trap EXIT runs when the script exits (any reason):

demo_exit_trap() {
  (
    trap 'echo "  Goodbye! Cleaning up..."' EXIT
    echo "  Working..."
    echo "  Done working"
  )
}

echo "EXIT trap demo:"
demo_exit_trap

: # Common signals to trap:
: # EXIT (0)   - Script exit (success or failure)
: # INT (2)    - Interrupt (Ctrl+C)
: # TERM (15)  - Termination request
: # HUP (1)    - Hangup
: # ERR        - On error (bash only)

: # Trap for cleanup of temporary files:

cleanup_tempfile() {
  (
    tmpfile="/tmp/trap_demo_$$"
    trap 'rm -f "$tmpfile"; echo "  Cleaned up $tmpfile"' EXIT

    echo "test data" >"$tmpfile"
    echo "  Created $tmpfile"
    echo "  File exists: $(test -f "$tmpfile" && echo yes || echo no)"
    # Cleanup happens automatically on exit
  )
}

echo "Temp file cleanup demo:"
cleanup_tempfile

: # Multiple commands in trap:

multi_cmd_trap() {
  (
    trap 'echo "  Step 1: Save state"; echo "  Step 2: Close files"' EXIT
    echo "  Running..."
  )
}

echo "Multi-command trap:"
multi_cmd_trap

: # Reset or ignore a trap:

echo "Ignore and reset trap:"
(
  # Ignore SIGINT (Ctrl+C)
  trap '' INT
  echo "  SIGINT now ignored"

  # Reset to default behavior
  trap - INT
  echo "  SIGINT reset to default"
)

: # Display current traps:

echo "Current traps:"
trap 'echo trapped' EXIT
trap -p
trap - EXIT

: # Trap with signal number instead of name:

(
  trap 'echo "  Caught signal"' 2 # 2 = SIGINT
  echo "  Trap set for signal 2"
)

: # Common pattern: cleanup function

cleanup() {
  echo "  Performing cleanup..."
  # Remove temp files, kill background processes, etc.
}

robust_script() {
  (
    trap cleanup EXIT
    echo "  Script running"
    # Even if something fails, cleanup runs
  )
}

echo "Cleanup function pattern:"
robust_script

: # Trap preserves exit code:

exit_code_demo() {
  (
    trap 'echo "  Trap ran, exit code was: $?"' EXIT
    exit 42
  )
  echo "  Subshell exited with: $?"
}

echo "Exit code preservation:"
exit_code_demo

: # Combining multiple signals:

(
  trap 'echo "  Interrupted or terminated"' INT TERM
  echo "  Trapping both INT and TERM"
)

: # [bash]
: # Bash provides ERR trap for errors:

# set -e
# trap 'echo "Error on line $LINENO"' ERR
# This runs on any command failure

: # DEBUG trap runs before each command:

# trap 'echo "Running: $BASH_COMMAND"' DEBUG
: # [/bash]

: # Practical example: Lock file with cleanup

demo_lockfile() {
  lockfile="/tmp/mylock_$$"

  (
    trap 'rm -f "$lockfile"' EXIT

    echo "  Creating lock: $lockfile"
    echo $$ >"$lockfile"

    echo "  Doing work..."
    sleep 1

    echo "  Lock will be removed on exit"
  )

  echo "  Lock removed: $(test -f "$lockfile" && echo no || echo yes)"
}

echo "Lock file pattern:"
demo_lockfile

: # Trap in a loop (handle Ctrl+C gracefully):

graceful_loop() {
  (
    running=true
    trap 'running=false; echo "  Stopping..."' INT TERM

    count=0
    while [ "$running" = true ] && [ "$count" -lt 3 ]; do
      count=$((count + 1))
      echo "  Iteration $count"
      sleep 1
    done
    echo "  Loop finished gracefully"
  )
}

echo "Graceful loop termination:"
graceful_loop

: # Best practice: Always trap EXIT for scripts that
: # create temporary resources.

echo "Done with trap examples"
