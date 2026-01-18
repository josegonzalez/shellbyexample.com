#!/bin/sh
# Temporary directory:

tmpdir=$(mktemp -d)
echo "Created temp dir: $tmpdir"
rmdir "$tmpdir"
