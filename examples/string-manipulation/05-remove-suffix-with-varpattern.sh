#!/bin/sh
# Remove suffix with `${var%pattern}` and `${var%%pattern}`.

# Remove shortest match from end
filepath="/home/user/documents/file.txt"
echo "Remove extension (%.*): ${filepath%.*}"

# Remove filename from end (get directory)
echo "Directory (%/*): ${filepath%/*}"
