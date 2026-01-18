#!/bin/sh
# Send cookies:

echo "Send cookies:"
curl -s -b "session=abc123" "https://httpbin.org/cookies" | grep -A3 '"cookies"'
