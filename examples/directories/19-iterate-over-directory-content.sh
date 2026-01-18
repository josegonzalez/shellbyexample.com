#!/bin/sh
# Iterate over directory contents with `for`:

mkdir -p /tmp/testdir
touch /tmp/testdir/file1.txt /tmp/testdir/file2.txt

echo "Loop over files:"
for file in /tmp/testdir/*; do
  [ -e "$file" ] || continue
  echo "  Found: $(basename "$file")"
done
