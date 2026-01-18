#!/bin/sh
# Multiple fields:

echo "Multiple fields:"
echo "$json" | jq -r '.name, .city'
