#!/bin/sh
# Secure temp file patterns. Don't use predictable names
# like `/tmp/myapp.$$` - the PID is predictable and creates
# a race condition. Use `mktemp` and set restrictive permissions:

tmpfile=$(mktemp)
chmod 600 "$tmpfile"
ls -la "$tmpfile"
rm "$tmpfile"
