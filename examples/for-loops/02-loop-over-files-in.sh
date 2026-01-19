#!/bin/sh
# Loop over files in a directory using globbing:

touch script1.sh script2.sh script3.sh

echo "Shell scripts in current directory:"
for file in *.sh; do
    # Check if glob matched anything
    [ -e "$file" ] || continue
    echo "  - $file"
done
