#!/bin/sh
# Read first N lines with `head`:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "First 2 lines (head):"
head -n 2 /tmp/sample.txt
