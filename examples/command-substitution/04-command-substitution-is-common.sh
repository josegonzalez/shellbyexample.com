#!/bin/sh
# Command substitution is commonly used to store
# command output in variables.

file_count=$(ls | wc -l)
echo "Files in current directory: $file_count"
