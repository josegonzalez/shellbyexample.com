#!/bin/sh
# PATCH request:

echo "PATCH request:"
curl -s -X PATCH "https://httpbin.org/patch" \
  -d "field=value" | grep -A2 '"form"'
