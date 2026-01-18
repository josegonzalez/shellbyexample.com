#!/bin/sh
# Truncate file to empty:

echo "content" >/tmp/truncate.txt
: >/tmp/truncate.txt # or > /tmp/truncate.txt
echo "After truncate, size: $(wc -c </tmp/truncate.txt) bytes"
