#!/bin/sh
# Custom directory template:

tmpdir=$(mktemp -d /tmp/myapp.XXXXXX)
echo "Custom temp dir: $tmpdir"
rm -rf "$tmpdir"
