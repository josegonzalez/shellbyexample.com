#!/bin/sh
# Count files in directory with `find` and `wc`:

mkdir -p /tmp/findtest
touch /tmp/findtest/file1.txt /tmp/findtest/file2.txt

echo "File count: $(find /tmp/findtest -type f | wc -l)"
