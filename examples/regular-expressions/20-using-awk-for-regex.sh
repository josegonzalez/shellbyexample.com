#!/bin/sh
# Using awk for regex:

echo "awk regex examples:"

# Match lines
echo "Lines matching /hello/:"
awk '/hello/' /tmp/sample.txt | head -3

# Negate match
echo "Lines NOT matching /hello/:"
awk '!/hello/' /tmp/sample.txt | head -3

# Match specific field
echo "Field matching:"
echo "alice 30" | awk '$1 ~ /^a/'
