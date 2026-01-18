#!/bin/sh
# Common regex patterns:

echo "Common patterns:"

# IP address (simplified)
echo "IP addresses:"
grep -E "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$" /tmp/sample.txt

# Date YYYY-MM-DD
echo "ISO dates:"
grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}$" /tmp/sample.txt

# Phone numbers
echo "Phone numbers:"
grep -E "[0-9]{3}.*[0-9]{4}" /tmp/sample.txt
