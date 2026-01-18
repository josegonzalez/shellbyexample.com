#!/bin/sh
# Read last N lines with `tail`:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Last 2 lines (tail):"
tail -n 2 /tmp/sample.txt
