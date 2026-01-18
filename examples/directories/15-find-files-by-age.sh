#!/bin/sh
# Find files by age with `-mtime`:

mkdir -p /tmp/findtest
touch /tmp/findtest/file1.txt /tmp/findtest/file2.txt

touch -d "2 days ago" /tmp/findtest/old.txt 2>/dev/null || touch /tmp/findtest/old.txt
echo "Files modified in last day:"
find /tmp/findtest -mtime -1 -type f
