#!/bin/bash
# Using process substitution instead of temp files.
# This avoids creating explicit temp files:

diff <(sort file1.txt) <(sort file2.txt)
while read -r line; do
    echo "$line"
done < <(some_command)
