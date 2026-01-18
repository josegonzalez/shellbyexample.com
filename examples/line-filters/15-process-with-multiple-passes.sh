#!/bin/sh
# Process with multiple passes:

echo "Multi-pass processing:"
# Pass 1: Filter
# Pass 2: Transform
cat /tmp/data.txt | grep -v "date" | awk '{print $1, $2 * 2}'
