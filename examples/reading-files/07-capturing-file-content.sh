#!/bin/sh
# Sometimes you need the entire file in a variable
# rather than processing it line by line. Command
# substitution with `cat` is the standard approach.
#
# Note: command substitution strips trailing newlines,
# so this works best for content you will process
# further rather than reproduce byte-for-byte.

cat >/tmp/message.txt <<'EOF'
Hello from the file.
This is line two.
EOF

content=$(cat /tmp/message.txt)
echo "=== File in a variable ==="
echo "$content"

# POSIX sh has no arrays, but you can store lines in
# positional parameters using `set --`. This gives you
# `$1`, `$2`, etc. for each line.
echo ""
echo "=== Lines as positional parameters ==="
printf "apple\nbanana\ncherry\n" >/tmp/fruits.txt

set --
while IFS= read -r line; do
    set -- "$@" "$line"
done </tmp/fruits.txt

echo "Count: $#"
echo "First: $1"
echo "Last:  $3"
echo "All:   $*"
