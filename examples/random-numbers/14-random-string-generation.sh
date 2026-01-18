#!/bin/sh
# Random string generation:

echo "Random strings:"

# Alphanumeric string
randstr=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | head -c 16)
echo "  Alphanumeric (16): $randstr"

# Hex string
randhex=$(od -An -tx1 -N8 /dev/urandom | tr -d ' \n')
echo "  Hex (16 chars): $randhex"

# Base64 string
if command -v base64 >/dev/null 2>&1; then
  randbase64=$(head -c 12 /dev/urandom | base64 | tr -d '\n')
  echo "  Base64: $randbase64"
fi
