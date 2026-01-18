#!/bin/sh
# Create JSON:

echo "Create JSON:"
jq -n --arg name "Dave" --arg age "25" \
  '{"name": $name, "age": ($age | tonumber)}'
