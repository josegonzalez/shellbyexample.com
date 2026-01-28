#!/bin/sh
# The standard pattern for processing a file one line
# at a time is `while IFS= read -r line`. The two flags
# matter:
#
# - `IFS=` prevents stripping leading/trailing whitespace
# - `-r` prevents backslash sequences like `\n` from
#   being interpreted
#
# Without them, data can silently change as you read it.

cat >/tmp/items.txt <<'EOF'
  indented line
line with \backslashes\
normal line
EOF

# Without the flags — whitespace stripped, backslashes eaten
echo "=== Without IFS= and -r (broken) ==="
while read line; do
    echo "  [$line]"
done </tmp/items.txt

# With the flags — data preserved exactly
echo ""
echo "=== With IFS= read -r (correct) ==="
while IFS= read -r line; do
    echo "  [$line]"
done </tmp/items.txt

# Adding line numbers is a common variant
echo ""
echo "=== With line numbers ==="
n=1
while IFS= read -r line; do
    echo "  $n: $line"
    n=$((n + 1))
done </tmp/items.txt
