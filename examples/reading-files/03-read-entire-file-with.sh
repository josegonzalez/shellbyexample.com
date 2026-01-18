#!/bin/sh
# Shell provides several ways to read file contents.
# This example covers common file reading patterns.
#
# Create a sample file for demonstration:
#
# Read entire file with `cat`:
cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

echo "Using cat:"
cat /tmp/sample.txt
