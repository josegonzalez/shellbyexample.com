#!/bin/bash
# Create array from command output.

files=($(ls *.sh 2>/dev/null))
echo "Shell files: ${files[@]}"
