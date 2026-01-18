#!/bin/sh
# Filter pattern: transform each line

echo "Transform each line (uppercase):"
printf "hello\nworld\n" | while read -r line; do
  echo "$line" | tr '[:lower:]' '[:upper:]'
done
