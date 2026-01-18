#!/bin/sh
# Download file:

echo "Download file:"
curl -s -O "https://httpbin.org/robots.txt" 2>/dev/null && {
  head -2 robots.txt
  rm robots.txt
}
