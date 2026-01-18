#!/bin/bash
# Process substitution:

while read -r line; do
    echo "Line: $line"
done < <(ls -la)
