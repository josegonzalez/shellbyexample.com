#!/bin/sh
# Find with `-exec`:

mkdir -p /tmp/findtest
touch /tmp/findtest/file1.txt /tmp/findtest/file2.txt

echo "Find and show sizes:"
find /tmp/findtest -type f -exec ls -la {} \;
