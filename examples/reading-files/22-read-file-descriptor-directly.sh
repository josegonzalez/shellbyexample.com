#!/bin/sh
# Read file descriptor directly:

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Using file descriptor:"
exec 3</tmp/sample.txt
read -r first_line <&3
echo "  First line: $first_line"
read -r second_line <&3
echo "  Second line: $second_line"
exec 3<&- # Close file descriptor
