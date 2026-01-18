#!/bin/sh
# Arrays:

array='[{"id":1,"name":"Alice"},{"id":2,"name":"Bob"},{"id":3,"name":"Carol"}]'

echo "Array access:"
echo "$array" | jq '.[0]'   # First element
echo "$array" | jq '.[-1]'  # Last element
echo "$array" | jq '.[1:3]' # Slice
