#!/bin/sh
# Custom prefix with template:

tmpfile=$(mktemp /tmp/myapp.XXXXXX)
echo "Custom prefix: $tmpfile"
rm "$tmpfile"
