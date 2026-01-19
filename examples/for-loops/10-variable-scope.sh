#!/bin/sh
# The loop variable persists after the loop ends, retaining
# the value from the last iteration. This differs from many
# programming languages where loop variables are scoped to
# the loop body.
#
# This behavior can be useful when you need to know the
# last processed item, but be careful to avoid accidentally
# reusing a variable name from a previous loop.

for letter in a b c; do
    : # do nothing (: is a no-op command)
done
echo "After loop, letter = $letter"

echo ""
echo "Practical use - find last matching item:"
last_txt=""
for file in /etc/passwd /etc/hosts /etc/fstab; do
    if [ -f "$file" ]; then
        last_txt="$file"
    fi
done
echo "Last existing file: $last_txt"
