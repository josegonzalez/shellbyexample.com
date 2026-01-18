#!/bin/sh
# Basic temporary file with mktemp:

tmpfile=$(mktemp)
echo "Created temp file: $tmpfile"
echo "Hello, temp!" >"$tmpfile"
cat "$tmpfile"
rm "$tmpfile"
