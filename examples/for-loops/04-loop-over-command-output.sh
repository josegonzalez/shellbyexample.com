#!/bin/sh
# Loop over command output using command substitution:

echo "Users with login shells:"
for user in $(cat /etc/passwd | cut -d: -f1 | head -5); do
    echo "  - $user"
done
