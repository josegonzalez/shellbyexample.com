#!/bin/sh
# Convert to/from other formats:

echo "To CSV-like:"
echo "$array" | jq -r '.[] | [.id, .name] | @csv'

echo "To shell variables:"
eval "$(echo "$json" | jq -r '@sh "name=\(.name) age=\(.age)"')"
echo "  name=$name, age=$age"

echo "JSON examples complete"
