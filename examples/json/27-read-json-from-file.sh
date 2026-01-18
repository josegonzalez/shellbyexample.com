#!/bin/sh
# Read JSON from file:

tmpfile=$(mktemp)
echo "$array" >"$tmpfile"
echo "From file:"
jq '.[0].name' "$tmpfile"
rm "$tmpfile"
