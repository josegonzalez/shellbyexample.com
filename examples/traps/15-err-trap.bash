#!/bin/bash
# Bash adds `ERR`, which runs when any command exits non-zero.
# Use `$?` to see the exit status, `$BASH_COMMAND` for the command.

trap 'echo "ERR: $BASH_COMMAND failed with status $?"' ERR

echo "Running commands..."
true
false
test -d /nonexistent
echo "Script continues after errors"
