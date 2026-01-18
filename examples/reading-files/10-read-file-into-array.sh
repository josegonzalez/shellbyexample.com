#!/bin/sh
# Read file into array (bash-specific shown later).
# POSIX sh lacks arrays, but we can use positional parameters.

# Create sample file
printf "apple\nbanana\ncherry\n" >/tmp/fruits.txt

# Store lines in positional parameters
set --
while IFS= read -r line; do
    set -- "$@" "$line"
done </tmp/fruits.txt

echo "Number of items: $#"
echo "First item: $1"
echo "All items: $*"

rm /tmp/fruits.txt
