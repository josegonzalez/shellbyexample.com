#!/bin/sh
# Basic write with > (overwrites existing file):

echo "Hello, World!" >/tmp/output.txt
echo "Created file with: $(cat /tmp/output.txt)"
