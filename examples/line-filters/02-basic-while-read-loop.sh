#!/bin/sh
# Basic while read loop:

echo "Basic line reading:"
printf "line1\nline2\nline3\n" | while read -r line; do
  echo "  Got: $line"
done
