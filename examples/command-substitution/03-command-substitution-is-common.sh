#!/bin/sh
# Command substitution is commonly used to store
# command output in variables.

file_count=$(find . -maxdepth 1 -type f -print | wc -l)
echo "Files in current directory: $file_count"
