#!/bin/sh
# Temporary files are essential for shell scripts that
# need to store intermediate data. The `mktemp` command
# creates them safely.
#
# Basic temporary file with `mktemp`:

tmpfile=$(mktemp)
echo "Created temp file: $tmpfile"
echo "Hello, temp!" >"$tmpfile"
cat "$tmpfile"
rm "$tmpfile"
