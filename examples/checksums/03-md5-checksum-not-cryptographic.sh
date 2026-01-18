#!/bin/sh
# MD5 checksum (not cryptographically secure, but fast):

echo "MD5 checksums:"
if command -v md5sum >/dev/null 2>&1; then
  # GNU/Linux
  md5sum /tmp/sample.txt
elif command -v md5 >/dev/null 2>&1; then
  # macOS/BSD
  md5 /tmp/sample.txt
fi
