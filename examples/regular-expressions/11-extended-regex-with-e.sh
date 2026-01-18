#!/bin/sh
# Extended regex with -E (or egrep):

echo "Extended regex patterns:"

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

# + matches one or more
echo "One or more digits:"
grep -E "[0-9]+" /tmp/sample.txt

# ? matches zero or one
echo "Optional 's' (phones?):"
grep -E "phones?" /tmp/sample.txt

# {n,m} matches n to m occurrences
echo "Exactly 3 digits:"
grep -E "[0-9]{3}" /tmp/sample.txt

# | for alternation
echo "Lines with 'hello' or 'test':"
grep -E "hello|test" /tmp/sample.txt
