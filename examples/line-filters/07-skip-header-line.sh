#!/bin/sh
# Skip header line:

echo "Skip header:"
cat >/tmp/csv.txt <<'EOF'
name,age,city
Alice,30,NYC
Bob,25,LA
Carol,35,Chicago
EOF

head -1 /tmp/csv.txt
tail -n +2 /tmp/csv.txt | while IFS=, read -r name age city; do
  echo "  $name (age $age) from $city"
done
