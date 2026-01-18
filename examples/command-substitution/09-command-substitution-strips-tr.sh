#!/bin/sh
# Command substitution strips trailing newlines from
# the output. This is usually what you want.

output=$(echo "Hello")
echo "Output: '$output'"
