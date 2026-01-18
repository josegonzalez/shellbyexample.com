#!/bin/sh
# Practical example - process files with path manipulation:
echo "Processing example:"
for file in /tmp/*.txt; do
    [ -e "$file" ] || continue
    dir=$(dirname "$file")
    name=$(basename "$file" .txt)
    echo "  Would create: $dir/${name}_backup.txt"
done

echo "File path examples complete"
