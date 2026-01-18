#!/bin/sh
# Process a file line by line:

cat >/tmp/data.txt <<'EOF'
apple 10 red
banana 20 yellow
cherry 15 red
date 25 brown
EOF

echo "Processing file:"
while read -r fruit count color; do
  echo "  $fruit ($color): $count items"
done </tmp/data.txt
