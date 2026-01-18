#!/bin/sh
# Negated character class with [^]:

echo "Lines with 'hello' NOT followed by digit:"
grep "hello[^0-9]" /tmp/sample.txt
