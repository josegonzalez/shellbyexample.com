#!/bin/sh
# Using openssl for checksums:

if command -v openssl >/dev/null 2>&1; then
  echo "OpenSSL checksums:"
  echo "  MD5: $(openssl md5 /tmp/sample.txt 2>/dev/null | awk '{print $NF}')"
  echo "  SHA256: $(openssl sha256 /tmp/sample.txt 2>/dev/null | awk '{print $NF}')"
fi
