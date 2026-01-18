#!/bin/sh
# SHA-256 checksum (recommended):

echo "SHA-256 checksums:"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt
fi
