#!/bin/bash
# Create array from command output.

touch file1.txt file2.txt file3.txt

# create array from command output using mapfile
mapfile -t files < <(find . -maxdepth 1 -type f -print)
echo "Shell files: ${files[*]}"
