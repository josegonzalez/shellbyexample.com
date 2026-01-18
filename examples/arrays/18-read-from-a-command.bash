#!/bin/bash
# Read from a command using process substitution:

mapfile -t users < <(cut -d: -f1 /etc/passwd | head -5)
echo "Users: ${users[@]}"
