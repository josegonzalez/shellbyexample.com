#!/bin/sh
# You can use command substitution in arithmetic.

files=$(ls | wc -l)
echo "Double the files: $((files * 2))"
