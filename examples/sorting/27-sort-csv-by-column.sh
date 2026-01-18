#!/bin/sh
# Sort CSV by column:

cat >/tmp/sales.csv <<'EOF'
product,quantity,price
Apple,100,1.50
Banana,50,0.75
Cherry,75,2.00
EOF

echo "Sort CSV by quantity (column 2):"
tail -n +2 /tmp/sales.csv | sort -t, -k2 -n
