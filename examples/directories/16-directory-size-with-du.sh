#!/bin/sh
# Directory size with `du`:

mkdir -p /tmp/testdir
mkdir -p /tmp/findtest
echo "Created test directories" >/tmp/testdir/file1.txt

echo "Directory sizes:"
du -sh /tmp/testdir
du -sh /tmp/findtest
