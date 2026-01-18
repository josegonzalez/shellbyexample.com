#!/bin/sh
# Here-document with variable expansion:

name="Alice"
cat >/tmp/template.txt <<EOF
Hello, $name!
Today is $(date)
Your home is $HOME
EOF
echo "Template with variables:"
cat /tmp/template.txt
