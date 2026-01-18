#!/bin/sh
# Retry on failure:

echo "Retry on failure:"
curl -s --retry 3 --retry-delay 1 "https://httpbin.org/get" >/dev/null && echo "  Success"
