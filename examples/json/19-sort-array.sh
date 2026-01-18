#!/bin/sh
# Sort array:

echo "Sort by name:"
echo "$array" | jq 'sort_by(.name)'

echo "Sort by id (reverse):"
echo "$array" | jq 'sort_by(.id) | reverse'
