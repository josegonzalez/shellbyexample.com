#!/bin/sh
# $@ expands to all arguments as separate words:

echo "All arguments (\$@):"
for arg in "$@"; do
  echo "  - $arg"
done
