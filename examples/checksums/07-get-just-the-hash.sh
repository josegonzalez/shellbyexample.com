#!/bin/sh
# Get just the hash value (no filename):

echo "Hash only:"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt | cut -d' ' -f1
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt | cut -d' ' -f1
fi
