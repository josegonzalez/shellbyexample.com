#!/bin/sh
# Hash a string (not a file):

echo "Hash a string:"
echo -n "password123" | sha256sum 2>/dev/null || echo -n "password123" | shasum -a 256
