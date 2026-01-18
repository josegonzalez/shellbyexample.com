#!/bin/sh
# Numbering lines:

echo "Number lines:"
n=1
printf "first\nsecond\nthird\n" | while read -r line; do
    printf "%3d: %s\n" "$n" "$line"
    n=$((n + 1))
done
