#!/bin/sh
# Display current traps:

echo "Current traps:"
trap 'echo trapped' EXIT
trap -p
trap - EXIT
