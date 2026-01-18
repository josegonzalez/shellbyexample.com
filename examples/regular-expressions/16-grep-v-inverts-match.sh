#!/bin/sh
# grep -v inverts match (show non-matching):

echo "Lines NOT containing 'hello':"
grep -v "hello" /tmp/sample.txt | head -5
