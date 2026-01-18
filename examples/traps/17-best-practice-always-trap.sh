#!/bin/sh
# Best practice: Always trap `EXIT` for scripts that
# create temporary resources. This ensures cleanup
# happens even if the script fails or is interrupted.

# Create temp file and set up cleanup
tmpfile="/tmp/example.123456"
touch "$tmpfile"
trap 'rm -f "$tmpfile"; echo "Cleaned up $tmpfile"' EXIT

echo "Created: $tmpfile"
echo "some data" >"$tmpfile"
cat "$tmpfile"

# Cleanup happens automatically when script exits
