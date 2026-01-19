#!/bin/sh
# Processing command output line by line is a common pattern.
# Pipe the command into a `while read` loop to handle each
# line individually.
#
# Important: Variables modified inside a piped `while` loop
# won't persist outside because pipes create a subshell.

echo "Processing lines from a command:"
printf '%s\n' "first" "second" "third" | while read -r line; do
    echo "  Got: $line"
done

# Demonstrating the subshell issue:
count=0
printf '%s\n' "a" "b" "c" | while read -r item; do
    count=$((count + 1))
done
echo "Count after piped loop: $count (still 0 due to subshell)"
