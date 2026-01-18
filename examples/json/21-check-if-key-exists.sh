#!/bin/sh
# Check if key exists:

echo "Key exists:"
echo "$json" | jq 'has("name")'
echo "$json" | jq 'has("email")'
