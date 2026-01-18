#!/bin/sh
# Using wget as an alternative to curl:

if command -v wget >/dev/null 2>&1; then
  echo "wget example:"
  wget -q -O - "https://httpbin.org/get" | head -5
fi
