#!/bin/sh
# Remove prefix with `${var#pattern}` and `${var##pattern}`.

filepath="/home/user/documents/file.txt"
echo "Path: $filepath"

# Remove shortest match from beginning
echo "Remove leading /: ${filepath#/}"

# Remove longest match from beginning
echo "Remove path (##*/): ${filepath##*/}"
