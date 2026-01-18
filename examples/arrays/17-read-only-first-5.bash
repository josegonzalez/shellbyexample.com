#!/bin/bash
# Read only first 5 lines:

mapfile -t -n 5 lines </etc/passwd
for line in "${lines[@]}"; do
    echo "$line"
done
