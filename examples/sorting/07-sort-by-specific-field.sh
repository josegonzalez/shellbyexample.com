#!/bin/sh
# Sort by specific field with -k:

cat >/tmp/data.txt <<'EOF'
Alice 30 NYC
Bob 25 LA
Carol 35 Chicago
Dave 25 Boston
EOF

echo "Sort by second field (age):"
sort -k2 -n /tmp/data.txt

echo "Sort by third field (city):"
sort -k3 /tmp/data.txt
