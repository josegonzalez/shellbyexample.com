#!/bin/sh
# Verify multiple files:

echo "Multiple file verification:"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt /tmp/other.txt >/tmp/checksums.txt
  sha256sum -c /tmp/checksums.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt /tmp/other.txt >/tmp/checksums.txt
  shasum -c /tmp/checksums.txt
fi
