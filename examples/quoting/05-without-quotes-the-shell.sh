#!/bin/sh
# Without quotes, the shell splits on spaces.
# This is called word splitting.

files="file1.txt file2.txt file3.txt"

# Without quotes: each word becomes a separate argument
echo "Without quotes:"
for f in $files; do
    echo "  $f"
done

# With quotes: entire string is one argument
echo "With quotes:"
# shellcheck disable=SC2066
for f in "$files"; do
    echo "  $f"
done
