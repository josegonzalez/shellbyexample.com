#!/bin/sh
# Conditional updates:

echo "Conditional update:"
echo "$array" | jq 'map(if .id == 2 then .name = "Robert" else . end)'
