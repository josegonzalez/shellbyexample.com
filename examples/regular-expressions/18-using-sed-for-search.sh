#!/bin/sh
# Using sed for search and replace:

echo "sed substitution examples:"

# Replace first occurrence
echo "hello world world" | sed 's/world/universe/'

# Replace all occurrences (g flag)
echo "hello world world" | sed 's/world/universe/g'

# Case-insensitive (I flag, GNU sed)
echo "Hello HELLO hello" | sed 's/hello/hi/gi'

# Delete lines matching pattern
echo "Delete lines with 'HELLO':"
sed '/HELLO/d' /tmp/sample.txt | head -3

# Print only matching lines (like grep)
echo "sed -n with /p:"
sed -n '/^hello/p' /tmp/sample.txt
