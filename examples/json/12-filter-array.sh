#!/bin/sh
# Filter array:

echo "Filter (id > 1):"
echo "$array" | jq '.[] | select(.id > 1)'
