#!/bin/sh
# Write multiple lines with here-document:

cat >/tmp/multiline.txt <<'EOF'
This is line 1
This is line 2
This is line 3
EOF
echo "Here-document file:"
cat /tmp/multiline.txt
