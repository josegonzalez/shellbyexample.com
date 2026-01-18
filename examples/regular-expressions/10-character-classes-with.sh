#!/bin/sh
# Character classes with []:

echo "Pattern 'hello[0-9]' (hello + digit):"
grep "hello[0-9]" /tmp/sample.txt

echo "Pattern 'hello[._-]' (hello + separator):"
grep "hello[._-]" /tmp/sample.txt
