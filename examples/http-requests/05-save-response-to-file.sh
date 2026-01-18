#!/bin/sh
# Save response to file:

curl -s -o /tmp/response.json "https://httpbin.org/get"
echo "Saved to file:"
head -5 /tmp/response.json
rm /tmp/response.json
