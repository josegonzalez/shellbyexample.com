#!/bin/sh
# Subshell traps are independent of the parent shell. A trap set
# in a subshell doesn't affect the parent, and vice versa.

trap 'echo "Parent trap"' EXIT

(
    trap 'echo "Child trap"' EXIT
    echo "In subshell..."
)

echo "Back in parent..."
trap - EXIT
echo "Parent trap cleared"
