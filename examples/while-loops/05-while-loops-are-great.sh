#!/bin/sh
# While loops are great for reading files line by line:

echo "Reading lines:"
while IFS= read -r line; do
  echo "  -> $line"
done <<'EOF'
First line
Second line
Third line
EOF
