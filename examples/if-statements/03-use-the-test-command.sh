#!/bin/sh
# Use the `test` command or `[ ]` for comparisons.
# Note: spaces inside `[ ]` are required!
#
# Numeric comparisons:
# - `-eq` (equal), `-ne` (not equal)
# - `-lt` (less than), `-le` (less or equal)
# - `-gt` (greater than), `-ge` (greater or equal)

value=10
count=5

if [ "$value" -eq 10 ]; then
    echo "Value is 10"
fi

if [ "$count" -gt 3 ]; then
    echo "Count is greater than 3"
fi
