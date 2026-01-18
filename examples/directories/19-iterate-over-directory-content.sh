#!/bin/sh
# Iterate over directory contents:

echo "Loop over files:"
for file in /tmp/testdir/*; do
  [ -e "$file" ] || continue
  echo "  Found: $(basename "$file")"
done
