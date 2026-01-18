#!/bin/sh
# Type checking:

echo "Type of value:"
echo "$json" | jq '.name | type'
echo "$json" | jq '.age | type'
echo "$json" | jq '.active | type'
