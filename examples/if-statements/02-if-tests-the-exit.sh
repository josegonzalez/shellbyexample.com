#!/bin/sh
# The `if` tests the exit status of a command.
# Exit status 0 means success (true), non-zero means
# failure (false).

if ls /tmp >/dev/null 2>&1; then
    echo "/tmp exists and is readable"
fi
