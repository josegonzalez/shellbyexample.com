#!/bin/sh
# BSD-style checksums:

if command -v sum >/dev/null 2>&1; then
  echo "BSD sum:"
  sum /tmp/sample.txt
fi
