#!/bin/sh
# SHA-1 checksum (deprecated for security, still used):

echo "SHA-1 checksums:"
if command -v sha1sum >/dev/null 2>&1; then
  sha1sum /tmp/sample.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 1 /tmp/sample.txt
fi
