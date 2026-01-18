#!/bin/sh
# Stable sort with -s (preserve original order for equal elements):

echo "Stable sort:"
cat >/tmp/scores.txt <<'EOF'
Alice 90
Bob 85
Carol 90
Dave 85
EOF

sort -s -k2 -n -r /tmp/scores.txt
