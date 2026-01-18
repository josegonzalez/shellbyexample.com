#!/bin/bash
# Process substitution:

diff <(ls /bin) <(ls /usr/bin)
while read -r line; do
    echo "Line: $line"
done < <(ls -la)
