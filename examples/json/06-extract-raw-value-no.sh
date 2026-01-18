#!/bin/sh
# Extract raw value (no quotes):

echo "Raw value:"
echo "$json" | jq -r '.name'
