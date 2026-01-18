#!/bin/sh
# Process lines with line numbers:

echo "With line numbers:"
n=1
while IFS= read -r line; do
  echo "  $n: $line"
  n=$((n + 1))
done </tmp/sample.txt
