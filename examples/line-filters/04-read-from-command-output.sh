#!/bin/sh
# Read from command output:

echo "Reading from command:"
ls -la /tmp 2>/dev/null | head -5 | while read -r line; do
  echo "  $line"
done
