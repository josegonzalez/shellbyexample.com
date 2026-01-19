#!/bin/sh
# Command substitution strips trailing newlines from
# the output. This is usually what you want.
#
# To preserve trailing newlines, append a character
# and then remove it with parameter expansion.

output="$(printf "Hello\n")"
echo "Output: '$output'"

output="$(printf "Hello\n"; printf x)"
output="${output%x}"
echo "Preserved: '$output'"
