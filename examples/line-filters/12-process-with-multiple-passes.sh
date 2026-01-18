#!/bin/sh
# Process with multiple passes using a subshell:

cat >/tmp/data.txt <<'EOF'
apple 10 red
banana 20 yellow
cherry 15 red
date 25 brown
EOF

# Pass 1: Filter
# Pass 2: Transform
cat /tmp/data.txt | grep -v "date" | awk '{print $1, $2 * 2}'
