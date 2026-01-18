#!/bin/sh
# Common exit codes by convention:
#
# - `0` - Success
# - `1` - General errors
# - `2` - Misuse of shell command
# - `126` - Command not executable
# - `127` - Command not found
# - `128+N` - Fatal error signal N
#
# Check exit code with `if` statement:

if grep -q "root" /etc/passwd; then
  echo "Found root user (grep returned 0)"
else
  echo "No root user found"
fi
