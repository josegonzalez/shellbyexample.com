#!/bin/sh
# Handle errors:

echo "Error handling:"
response=$(curl -s -w "\n%{http_code}" "https://httpbin.org/status/500")
body=$(echo "$response" | sed '$d')
code=$(echo "$response" | tail -1)

if [ "$code" -ge 400 ]; then
  echo "  Error: HTTP $code"
else
  echo "  Success: HTTP $code"
fi

echo "HTTP requests examples complete"
