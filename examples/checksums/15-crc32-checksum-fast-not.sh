#!/bin/sh
# CRC32 checksum (fast, not secure):

if command -v cksum >/dev/null 2>&1; then
  echo "CRC checksum:"
  cksum /tmp/sample.txt
fi
