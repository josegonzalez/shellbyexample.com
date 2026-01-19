#!/bin/sh
# You can use command substitution in arithmetic if the
# output is a number.

touch file1.txt file2.txt file3.txt
file_count="$(find . -maxdepth 1 -type f -print | wc -l)"
echo "File count: $file_count"
echo "Double the files: $((file_count * 2))"
