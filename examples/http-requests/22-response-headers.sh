#!/bin/sh
# Response headers:

echo "Response headers:"
curl -s -I "https://httpbin.org/get" | head -5
