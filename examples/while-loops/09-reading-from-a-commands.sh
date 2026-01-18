#!/bin/sh
# Reading from a command's output:

echo "First 3 users:"
who | head -3 | while read -r user tty rest; do
  echo "  User: $user on $tty"
done
