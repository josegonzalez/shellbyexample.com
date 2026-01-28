#!/bin/sh
# Many Unix files use delimiters to separate fields —
# `/etc/passwd` uses colons, CSVs use commas. Setting
# `IFS` to the delimiter lets `read` split each line
# into separate variables automatically.

cat >/tmp/staff.csv <<'EOF'
alice:30:engineer
bob:25:designer
carol:35:manager
EOF

# IFS=: tells read to split on colons
echo "=== Parsing colon-delimited data ==="
while IFS=: read -r name age role; do
    echo "  $name is $age, works as $role"
done </tmp/staff.csv

# A subtle bug: if the file's last line has no trailing
# newline, `read` returns false and the line is skipped.
# Adding `|| [ -n "$line" ]` catches this case.
echo ""
echo "=== Handling missing final newline ==="
printf "red:apple\ngreen:pear" >/tmp/colors.txt
while IFS=: read -r color fruit || [ -n "$color" ]; do
    echo "  $color -> $fruit"
done </tmp/colors.txt
