#!/bin/sh
# Extract a field:

echo "Extract field:"
echo "$json" | jq '.name'
