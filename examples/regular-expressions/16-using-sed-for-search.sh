#!/bin/sh
# Use `sed` for search and replace:

echo "sed substitution examples:"

# Replace first occurrence
echo "hello world world" | sed 's/world/universe/'

# Replace all occurrences (g flag)
echo "hello world world" | sed 's/world/universe/g'

# Case-insensitive (I flag, GNU sed)
echo "Hello HELLO hello" | sed 's/hello/hi/gi'

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

# Delete lines matching pattern
echo "Delete lines with 'HELLO':"
sed '/HELLO/d' /tmp/sample.txt | head -3

# Print only matching lines (like grep)
echo "sed -n with /p:"
sed -n '/^hello/p' /tmp/sample.txt
