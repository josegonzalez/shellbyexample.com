#!/bin/sh
# Transform array:

echo "Transform (add field):"
echo "$array" | jq 'map(. + {status: "active"})'
