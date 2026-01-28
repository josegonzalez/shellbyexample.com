#!/bin/sh
# The simplest way to read a file is with `cat`, short
# for "concatenate". Despite its name, `cat` is most
# often used to display a single file — but its real
# purpose is joining multiple files together.

# Create sample files for demonstration
cat >/tmp/greeting.txt <<'EOF'
Hello, World!
Welcome to shell scripting.
EOF

cat >/tmp/farewell.txt <<'EOF'
Goodbye for now.
See you next time!
EOF

# Display a single file
echo "=== Single file ==="
cat /tmp/greeting.txt

# Concatenate two files into one stream
echo ""
echo "=== Two files combined ==="
cat /tmp/greeting.txt /tmp/farewell.txt
