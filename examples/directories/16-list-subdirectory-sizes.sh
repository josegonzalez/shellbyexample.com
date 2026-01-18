#!/bin/sh
# List subdirectory sizes with `du`:

mkdir -p /tmp/findtest
touch /tmp/findtest/file1.txt /tmp/findtest/file2.txt

echo "Subdirectory sizes:"
du -h /tmp/findtest
