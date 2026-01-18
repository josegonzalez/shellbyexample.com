#!/bin/sh
# Create from variables:

name="Eve"
age="28"
echo "From variables:"
jq -n --arg n "$name" --argjson a "$age" '{"name": $n, "age": $a}'
