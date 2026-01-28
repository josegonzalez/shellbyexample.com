#!/bin/sh
# Before reading a file, check that it exists. Wrapping
# the check in a function makes it reusable across your
# script.
#
# For more control, file descriptors let you open a file
# once and read from it at your own pace — useful when
# you need the first few lines without processing the
# whole file.

# A reusable "safe read" function
read_file() {
    if [ ! -f "$1" ]; then
        echo "Error: $1 not found" >&2
        return 1
    fi
    cat "$1"
}

cat >/tmp/data.txt <<'EOF'
first
second
third
EOF

echo "=== Safe read (file exists) ==="
read_file /tmp/data.txt

echo ""
echo "=== Safe read (file missing) ==="
read_file /tmp/no_such_file.txt 2>&1 || true

# File descriptors: open with exec, read lines, then close
echo ""
echo "=== File descriptors ==="
exec 3</tmp/data.txt
read -r line1 <&3
read -r line2 <&3
exec 3<&-
echo "First line:  $line1"
echo "Second line: $line2"
