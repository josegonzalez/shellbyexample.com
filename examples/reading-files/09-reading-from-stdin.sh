#!/bin/sh
# Not all input comes from files. Programs often read
# from standard input (stdin), which can come from a
# pipe, a redirect, or the terminal.
#
# `read -r` reads one line from stdin. `cat` (with no
# arguments) or `cat -` copies all of stdin to stdout,
# which is useful in pipelines.

# Reading piped input line by line
echo "=== Pipe into while-read ==="
printf "one\ntwo\nthree\n" | while IFS= read -r line; do
    echo "  got: $line"
done

# read -r grabs a single line from stdin
echo ""
echo "=== Single read from a pipe ==="
result=$(echo "hello from pipe" | { read -r val; echo "$val"; })
echo "  $result"

# cat - reads all of stdin (the dash is optional but
# makes the intent explicit in scripts)
echo ""
echo "=== cat - passes stdin through ==="
echo "piped through cat" | cat -
