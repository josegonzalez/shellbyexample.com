#!/bin/sh
# Reading from a command's output:
#
# Note: Variables modified inside a piped while loop
# won't persist outside due to subshell behavior.
#
# Use process substitution or here-string to avoid subshells.
# In POSIX sh, redirect from a temp file or use a different approach.

echo "First 3 users:"
who | head -3 | while read -r user tty rest; do
    echo "  User: $user on $tty"
done
