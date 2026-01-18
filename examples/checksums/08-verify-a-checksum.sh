#!/bin/sh
# Verify a checksum:

echo "Verify checksum:"

# Create checksum file
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt >/tmp/checksum.txt
  echo "  Verification result:"
  sha256sum -c /tmp/checksum.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt >/tmp/checksum.txt
  echo "  Verification result:"
  shasum -c /tmp/checksum.txt
fi
