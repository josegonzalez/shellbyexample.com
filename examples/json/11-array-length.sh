#!/bin/sh
# Array length:

echo "Array length: $(echo "$array" | jq 'length')"
