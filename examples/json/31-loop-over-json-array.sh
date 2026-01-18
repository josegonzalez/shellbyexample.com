#!/bin/sh
# Loop over JSON array in shell:

echo "Loop in shell:"
echo "$array" | jq -c '.[]' | while read -r item; do
  name=$(echo "$item" | jq -r '.name')
  echo "  Processing: $name"
done
