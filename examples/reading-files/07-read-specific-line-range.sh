#!/bin/sh
# Read specific line range:

echo "Lines 2-4 (sed):"
sed -n '2,4p' /tmp/sample.txt
