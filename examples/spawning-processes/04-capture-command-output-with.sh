#!/bin/sh
# Capture command output with `$()`:

# shellcheck disable=SC2012
files=$(ls -1 /tmp | head -3)
echo "Captured output:"
echo "$files"
