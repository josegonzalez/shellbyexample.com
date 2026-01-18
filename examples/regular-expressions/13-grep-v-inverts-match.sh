#!/bin/sh
# grep `-v` inverts the match (shows non-matching):

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

echo "Lines NOT containing 'hello':"
grep -v "hello" /tmp/sample.txt | head -5
