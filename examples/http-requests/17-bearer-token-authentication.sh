#!/bin/sh
# Bearer token authentication:

curl -s "https://httpbin.org/bearer" \
  -H "Authorization: Bearer mytoken" | head -3
