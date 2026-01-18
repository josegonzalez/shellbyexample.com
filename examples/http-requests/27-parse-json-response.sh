#!/bin/sh
# Parse JSON response:

if command -v jq >/dev/null 2>&1; then
  echo "Parse JSON response:"
  curl -s "https://httpbin.org/get?foo=bar" | jq -r '.args.foo'
fi
