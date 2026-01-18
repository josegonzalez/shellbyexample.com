#!/bin/sh
# Use `awk` for regex:

cat >/tmp/sample.txt <<'EOF'
alice 30
bob 25
charlie 35
hello 40
EOF

echo "awk regex examples:"

# Match lines
echo "Lines matching /hello/:"
awk '/hello/' /tmp/sample.txt | head -3

# Negate match
echo "Lines NOT matching /hello/:"
awk '!/hello/' /tmp/sample.txt | head -3

# Match specific field
echo "Field matching:"
echo "alice 30" | awk '$1 ~ /^a/'
