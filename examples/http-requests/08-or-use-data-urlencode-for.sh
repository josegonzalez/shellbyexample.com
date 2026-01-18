#!/bin/sh
# Or use --data-urlencode for encoding:

curl -s -G "https://httpbin.org/get" \
  --data-urlencode "query=hello world" | grep -A2 '"args"'
