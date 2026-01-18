#!/bin/sh
# Default values:

echo "Default for missing:"
echo "$json" | jq '.email // "no email"'
