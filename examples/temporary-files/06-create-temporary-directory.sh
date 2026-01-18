#!/bin/sh
# Create temporary directory:

tmpdir=$(mktemp -d)
echo "Created temp dir: $tmpdir"
touch "$tmpdir/file1.txt"
touch "$tmpdir/file2.txt"
ls "$tmpdir"
rm -rf "$tmpdir"
