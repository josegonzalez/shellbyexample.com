#!/bin/bash
# Display current traps can be done with `trap -p` command.
#
# The syntax is:
#   trap -p
#
# If the trap is set, the output will be the trap command.
# Otherwise, the output will be empty.
#
# This example shows how to display current traps.

echo "Current traps:"
trap 'echo trapped' EXIT
trap -p
trap - EXIT
