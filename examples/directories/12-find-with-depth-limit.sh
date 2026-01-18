#!/bin/sh
# Find with depth limit with `-maxdepth`:

mkdir -p /tmp/findtest
touch /tmp/findtest/file1.txt /tmp/findtest/file2.txt

echo "Max depth 1:"
find /tmp/findtest -maxdepth 1 -type f
