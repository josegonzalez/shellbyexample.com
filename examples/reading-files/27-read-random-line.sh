#!/bin/sh
# Read random line:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Random line:"
shuf -n 1 /tmp/sample.txt 2>/dev/null ||
  awk 'BEGIN{srand()} {lines[NR]=$0} END{print lines[int(rand()*NR)+1]}' /tmp/sample.txt
