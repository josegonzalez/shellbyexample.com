#!/bin/sh
# Command substitution `$(command)` lets you loop over
# the output of any command. The output is split into
# words, and the loop iterates over each word.
#
# This pattern is useful for processing dynamic data
# like usernames, package lists, or filtered results.
#
# Caution: word splitting occurs on spaces, tabs, and
# newlines. If your data contains spaces, consider using
# `while read` instead (covered in while-loops).

echo "First 5 users from /etc/passwd:"
for user in $(cut -d: -f1 /etc/passwd | head -5); do
    echo "  - $user"
done

echo ""
echo "Simple word list from echo:"
for word in $(echo "one two three"); do
    echo "  word: $word"
done
