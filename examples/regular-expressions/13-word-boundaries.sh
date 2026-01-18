#!/bin/sh
# Word boundaries:

echo "Word 'hello' (not part of larger word):"
grep -w "hello" /tmp/sample.txt
