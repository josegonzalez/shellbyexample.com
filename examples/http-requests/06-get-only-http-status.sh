#!/bin/sh
# Get only HTTP status code:

echo "Status code only:"
status=$(curl -s -o /dev/null -w '%{http_code}' "https://httpbin.org/status/200")
echo "Status: $status"
