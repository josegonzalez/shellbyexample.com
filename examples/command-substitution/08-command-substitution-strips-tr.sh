#!/bin/sh
# Command substitution strips trailing newlines from
# the output. This is usually what you want.

output="$(printf "Hello\n")"
echo "Output: '$output'"
