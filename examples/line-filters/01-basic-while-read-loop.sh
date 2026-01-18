#!/bin/sh
# Line filters read from stdin, transform data, and
# write to stdout. The `while read` pattern is the
# foundation of shell line processing.
# Here's a basic `while read` loop that reads from stdin.
# The `-r` flag prevents backslash interpretation.
# Always use quotes around `$line` to preserve whitespace.

echo "Basic line reading:"
printf "line1\nline2\nline3\n" | while read -r line; do
  echo "  Got: $line"
done
