#!/bin/sh
# Read compressed files:

echo "Test" | gzip >/tmp/test.gz
echo "Compressed file content:"
zcat /tmp/test.gz 2>/dev/null || gzip -dc /tmp/test.gz
rm /tmp/test.gz
