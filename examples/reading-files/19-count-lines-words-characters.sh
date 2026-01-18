#!/bin/sh
# Count lines, words, characters:

echo "File statistics:"
wc /tmp/sample.txt | while read -r lines words chars filename; do
  echo "  Lines: $lines"
  echo "  Words: $words"
  echo "  Chars: $chars"
done
