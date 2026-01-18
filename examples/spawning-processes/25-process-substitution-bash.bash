#!/bin/bash
# Process substitution in bash can be performed via <(command) or >(command).
# This is usually done in order to avoid creating temporary files.

touch /tmp/test.txt
touch /tmp/test2.txt

while read -r line; do
    echo "Line: $line"
done < <(ls)
