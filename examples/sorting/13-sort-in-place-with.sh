#!/bin/sh
# Sort in place with -o (output to same file):

echo "apple" >/tmp/fruits.txt
echo "cherry" >>/tmp/fruits.txt
echo "banana" >>/tmp/fruits.txt
sort -o /tmp/fruits.txt /tmp/fruits.txt
echo "Sorted in place:"
cat /tmp/fruits.txt
