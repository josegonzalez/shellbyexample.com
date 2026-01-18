#!/bin/sh
# Read with grep filtering:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Lines containing 'Line':"
grep "Line" /tmp/sample.txt
