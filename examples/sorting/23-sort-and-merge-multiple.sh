#!/bin/sh
# Sort and merge multiple files:

echo "one" >/tmp/f1.txt
echo "three" >>/tmp/f1.txt
echo "two" >/tmp/f2.txt
echo "four" >>/tmp/f2.txt

echo "Merge sorted files:"
sort /tmp/f1.txt /tmp/f2.txt
