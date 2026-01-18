#!/bin/sh
# Read file line by line with while loop:

echo "Reading line by line:"
while IFS= read -r line; do
  echo "  -> $line"
done </tmp/sample.txt
