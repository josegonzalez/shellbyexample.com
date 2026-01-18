#!/bin/sh
# The `*` metacharacter matches zero or more of the previous character

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

echo "Pattern 'hel*o' (zero or more 'l'):"
grep "hel*o" /tmp/sample.txt
