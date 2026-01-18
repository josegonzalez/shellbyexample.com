#!/bin/sh
# `IFS=` prevents leading/trailing whitespace stripping.
# `-r` prevents backslash interpretation.
#
# Process lines with line numbers:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "With line numbers:"
n=1
while IFS= read -r line; do
    echo "  $n: $line"
    n=$((n + 1))
done </tmp/sample.txt
