#!/bin/sh
# Set timeout:

echo "With timeout:"
if curl -s --connect-timeout 5 --max-time 10 "https://httpbin.org/delay/1" >/dev/null; then
  echo "  Request completed"
fi
