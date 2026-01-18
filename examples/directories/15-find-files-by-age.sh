#!/bin/sh
# Find files by age:

touch -d "2 days ago" /tmp/findtest/old.txt 2>/dev/null || touch /tmp/findtest/old.txt
echo "Files modified in last day:"
find /tmp/findtest -mtime -1 -type f
