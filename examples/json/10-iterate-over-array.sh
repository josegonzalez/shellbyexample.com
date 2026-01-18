#!/bin/sh
# Iterate over array:

echo "Array iteration:"
echo "$array" | jq -r '.[].name'
