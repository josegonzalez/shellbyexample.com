#!/bin/sh
# Find with `-exec`:

mkdir -p /tmp/findtest
touch /tmp/findtest/file1.txt /tmp/findtest/file2.txt

echo "Find files and list them:"
find /tmp/findtest -type f -exec ls {} \;
