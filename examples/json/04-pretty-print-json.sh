#!/bin/sh
# Pretty print JSON:

echo "Pretty print:"
echo "$json" | jq '.'
