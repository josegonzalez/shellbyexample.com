#!/bin/sh
# Traps are also available in subshells, and will fire when
# the specified signal is received for that subshell.

(
    trap 'echo "Goodbye!"' EXIT

    echo "Script is running..."
    echo "About to exit..."
)
