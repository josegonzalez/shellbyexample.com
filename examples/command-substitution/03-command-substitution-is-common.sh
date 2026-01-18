#!/bin/sh
# Command substitution is commonly used to store
# command output in variables.

# shellcheck disable=SC2012
file_count=$(ls | wc -l)
echo "Files in current directory: $file_count"
