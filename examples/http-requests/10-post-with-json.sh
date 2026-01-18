#!/bin/sh
# POST with JSON:

echo "POST JSON:"
curl -s -X POST "https://httpbin.org/post" \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","age":30}' | grep -A5 '"json"'
