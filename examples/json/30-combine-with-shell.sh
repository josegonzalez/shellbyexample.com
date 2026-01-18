#!/bin/sh
# Combine with shell:

echo "Shell integration:"
result=$(echo "$json" | jq -r '.name')
echo "Name is: $result"
