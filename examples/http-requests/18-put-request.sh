#!/bin/sh
# PUT request:

echo "PUT request:"
curl -s -X PUT "https://httpbin.org/put" \
  -H "Content-Type: application/json" \
  -d '{"key":"value"}' | grep -A3 '"json"'
