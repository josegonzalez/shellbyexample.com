#!/bin/sh
# Read file line by line with while loop:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Reading line by line:"
while IFS= read -r line; do
    echo "  -> $line"
done </tmp/sample.txt
