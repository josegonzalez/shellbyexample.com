#!/bin/sh
# POST request with form data:

echo "POST form data:"
curl -s -X POST "https://httpbin.org/post" \
  -d "name=Alice" \
  -d "age=30" | grep -A5 '"form"'
