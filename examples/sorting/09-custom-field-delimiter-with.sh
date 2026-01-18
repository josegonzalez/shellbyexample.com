#!/bin/sh
# Custom field delimiter with -t:

cat >/tmp/passwd.txt <<'EOF'
root:0:root
alice:1000:Alice User
bob:1001:Bob Smith
daemon:1:daemon
EOF

echo "Sort /etc/passwd-like by UID (field 2):"
sort -t: -k2 -n /tmp/passwd.txt
