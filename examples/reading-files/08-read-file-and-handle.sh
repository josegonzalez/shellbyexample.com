#!/bin/sh
# Read file and handle last line without newline:

printf "no newline" >/tmp/nolf.txt
echo "Reading file without final newline:"
while IFS= read -r line || [ -n "$line" ]; do
    echo "  [$line]"
done </tmp/nolf.txt
rm /tmp/nolf.txt
