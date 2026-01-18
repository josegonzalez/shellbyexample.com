#!/bin/sh
# Append with >> (adds to end of file):

echo "First line" >/tmp/append.txt
echo "Second line" >>/tmp/append.txt
echo "Third line" >>/tmp/append.txt
echo "Appended file:"
cat /tmp/append.txt
