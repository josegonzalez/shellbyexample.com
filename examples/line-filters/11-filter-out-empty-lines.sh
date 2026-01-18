#!/bin/sh
# Filter out empty lines:

echo "Skip empty lines:"
printf "line1\n\nline2\n\nline3\n" | while read -r line; do
  [ -z "$line" ] && continue
  echo "  $line"
done
