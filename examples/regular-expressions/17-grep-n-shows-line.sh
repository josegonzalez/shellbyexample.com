#!/bin/sh
# grep -n shows line numbers:

echo "With line numbers:"
grep -n "world" /tmp/sample.txt | head -3
