#!/bin/sh
# SHA-512 checksum (highest security):

echo "SHA-512 checksums:"
if command -v sha512sum >/dev/null 2>&1; then
  sha512sum /tmp/sample.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 512 /tmp/sample.txt
fi
