#!/bin/sh
# Set restrictive permissions:

tmpfile=$(mktemp)
chmod 600 "$tmpfile" # Read/write for owner only
ls -la "$tmpfile"
rm "$tmpfile"
