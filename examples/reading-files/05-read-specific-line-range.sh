#!/bin/sh
# Read specific line range:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Lines 2-4 (sed):"
sed -n '2,4p' /tmp/sample.txt
