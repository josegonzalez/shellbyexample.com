#!/bin/sh
# Custom headers:

echo "Custom headers:"
curl -s "https://httpbin.org/headers" \
  -H "X-Custom-Header: MyValue" \
  -H "Authorization: Bearer token123" | grep -E '"X-Custom|Authorization"'
