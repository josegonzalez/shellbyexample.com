#!/bin/sh
# Error handling:

echo "Safe access (null for missing):"
echo "$json" | jq '.missing?'

echo "Try-catch:"
echo '{"x": "not a number"}' | jq 'try (.x | tonumber) catch "invalid"'
