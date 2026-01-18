#!/bin/sh
# Read file into a variable:

content=$(cat /tmp/sample.txt)
echo "File content in variable:"
echo "$content"
