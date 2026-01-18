#!/bin/sh
# Write to multiple files at once:

echo "Multiple files" | tee /tmp/file1.txt /tmp/file2.txt >/dev/null
echo "File1: $(cat /tmp/file1.txt)"
echo "File2: $(cat /tmp/file2.txt)"
