#!/bin/sh
# Check if file exists before reading:

read_safe() {
  if [ ! -f "$1" ]; then
    echo "Error: File not found: $1" >&2
    return 1
  fi
  cat "$1"
}

cat >/tmp/sample.txt <<'EOF'
Line 1: Hello
Line 2: World
Line 3: Shell
Line 4: Scripting
Line 5: Example
EOF

read_safe /tmp/sample.txt >/dev/null && echo "File read successfully"
read_safe /nonexistent 2>&1 || true
