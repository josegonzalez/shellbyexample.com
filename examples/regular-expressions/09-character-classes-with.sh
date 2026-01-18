#!/bin/sh
# Use `[]` to define character classes:

cat >/tmp/sample.txt <<'EOF'
hello world
Hello World
HELLO WORLD
hello123
hello-world
hello_world
hello.world
test@example.com
user123@domain.org
192.168.1.1
10.0.0.255
2024-03-15
03/15/2024
phone: 555-1234
phone: (555) 123-4567
EOF

echo "Pattern 'hello[0-9]' (hello + digit):"
grep "hello[0-9]" /tmp/sample.txt

echo "Pattern 'hello[._-]' (hello + separator):"
grep "hello[._-]" /tmp/sample.txt
