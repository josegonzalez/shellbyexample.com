#!/bin/sh
# Do this instead:

safe_tmpfile=$(mktemp)
echo "Safe temp file: $safe_tmpfile"
rm "$safe_tmpfile"
