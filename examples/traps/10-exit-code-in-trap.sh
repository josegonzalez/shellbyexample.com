#!/bin/sh
# Inside a trap, $? contains the exit code that triggered the
# trap. This lets you log or react to how the script exited.
#
# Traps don't change the script's exit code. The original exit
# status is preserved after the trap runs.

trap 'echo "Trap saw exit code: $?"' EXIT

echo "Exiting with code 42..."
exit 42
