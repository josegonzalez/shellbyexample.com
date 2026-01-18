#!/bin/sh
# Read from command output:

echo "Reading from command:"
# shellcheck disable=SC2012
ls -la /tmp 2>/dev/null | head -5 | while read -r line; do
  echo "  $line"
done
