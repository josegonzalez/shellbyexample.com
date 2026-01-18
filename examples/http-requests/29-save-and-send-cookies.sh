#!/bin/sh
# Save and send cookies:

echo "Save and send cookies:"
curl -s -c /tmp/cookies.txt "https://httpbin.org/cookies/set?session=abc123" >/dev/null
curl -s -b /tmp/cookies.txt "https://httpbin.org/cookies" | grep -A2 '"cookies"'
rm /tmp/cookies.txt
