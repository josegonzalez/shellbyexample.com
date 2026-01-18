#!/bin/sh
# Read file into a variable:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

content=$(cat /tmp/sample.txt)
echo "File content in variable:"
echo "$content"
