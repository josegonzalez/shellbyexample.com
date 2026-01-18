#!/bin/sh
# Read specific fields from each line:

cat >/tmp/data.txt <<'EOF'
alice:30:engineer
bob:25:designer
carol:35:manager
EOF

echo "Reading colon-separated fields:"
while IFS=: read -r name age job; do
  echo "  $name is a $age year old $job"
done </tmp/data.txt
