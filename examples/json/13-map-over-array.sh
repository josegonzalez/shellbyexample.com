#!/bin/sh
# Map over array:

echo "Map (extract names):"
echo "$array" | jq '[.[].name]'
