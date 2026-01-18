#!/bin/sh
# Hash directory contents:

echo "Directory checksum:"
tmpdir=$(mktemp -d)
echo "file1" >"$tmpdir/a.txt"
echo "file2" >"$tmpdir/b.txt"

# Hash all files and then hash the result
if command -v sha256sum >/dev/null 2>&1; then
  find "$tmpdir" -type f -exec sha256sum {} \; | sort | sha256sum
else
  find "$tmpdir" -type f -exec shasum -a 256 {} \; | sort | shasum -a 256
fi
rm -rf "$tmpdir"
