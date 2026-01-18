#!/bin/sh
# Modify JSON:

echo "Add field:"
echo "$json" | jq '. + {"country": "USA"}'

echo "Update field:"
echo "$json" | jq '.age = 31'

echo "Delete field:"
echo "$json" | jq 'del(.city)'
