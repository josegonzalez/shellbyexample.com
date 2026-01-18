#!/bin/sh
# Parallel requests with xargs:

echo "Parallel requests:"
printf '%s\n' "https://httpbin.org/get?id=1" "https://httpbin.org/get?id=2" "https://httpbin.org/get?id=3" | xargs -n1 -P3 -I{} sh -c 'curl -s "{}" | grep -o "\"id\": \"[0-9]*\"" | head -1'
