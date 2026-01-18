#!/bin/sh
# You can use command substitution in arithmetic.

files=$(find . -maxdepth 1 -type f -print | wc -l)
echo "Double the files: $((files * 2))"
