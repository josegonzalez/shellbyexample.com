#!/bin/sh
# Practical example: Log analyzer

cat >/tmp/access.log <<'EOF'
192.168.1.1 GET /index.html 200
192.168.1.2 GET /about.html 200
192.168.1.1 POST /api/data 201
192.168.1.3 GET /index.html 404
192.168.1.2 GET /contact.html 200
EOF

echo "Log analysis:"
echo "  Unique IPs:"
cut -d' ' -f1 /tmp/access.log | sort -u | while read -r ip; do
  echo "    $ip"
done

echo "  Status code counts:"
cut -d' ' -f4 /tmp/access.log | sort | uniq -c
