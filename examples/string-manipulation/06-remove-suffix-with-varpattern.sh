#!/bin/sh
# Remove suffix with ${var%pattern} and ${var%%pattern}:

# Remove shortest match from end
echo "Remove extension (%.*): ${filepath%.*}"

# Remove filename from end (get directory)
echo "Directory (%/*): ${filepath%/*}"
