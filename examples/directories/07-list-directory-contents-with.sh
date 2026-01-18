#!/bin/sh
# List directory contents with ls:

mkdir -p /tmp/testdir
touch /tmp/testdir/file1.txt /tmp/testdir/file2.sh

echo "List directory:"
ls /tmp/testdir

echo "Detailed listing:"
ls -la /tmp/testdir

echo "One file per line:"
ls -1 /tmp/testdir
