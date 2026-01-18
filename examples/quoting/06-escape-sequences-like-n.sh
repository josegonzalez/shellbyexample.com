#!/bin/sh
# Escape sequences like `\n` and `\t` are NOT interpreted in
# double quotes by POSIX echo. For reliable newlines, use literal
# newlines or printf. Note: `$'...'` works in bash but not POSIX.

# shellcheck disable=SC2028
echo "Line 1\nLine 2" # \n is NOT interpreted here

# shellcheck disable=SC2028
echo "Tab:\tseparated" # \t is NOT interpreted here

# Use literal newlines instead:
echo "Line 1
Line 2"
