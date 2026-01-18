#!/bin/sh
# Compact output (no pretty print):

echo "Compact:"
echo "$array" | jq -c '.'
