#!/bin/sh
# Rate limiting (pause between requests):

echo "Rate limited requests:"
for i in 1 2 3; do
  curl -s "https://httpbin.org/get" >/dev/null
  echo "  Request $i completed"
  sleep 1
done
