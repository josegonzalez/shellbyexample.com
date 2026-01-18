#!/bin/bash
# Bash provides mapfile/readarray for reading into arrays:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

mapfile -t lines </tmp/sample.txt
echo "Number of lines: ${#lines[@]}"
echo "First line: ${lines[0]}"
