#!/bin/sh
# Basic GET request:

echo "GET request:"
curl -s "https://httpbin.org/get" | head -10
