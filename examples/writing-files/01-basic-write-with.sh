#!/bin/sh
# Shell provides several ways to write data to files
# using redirection operators. This example covers
# common file writing patterns.
#
# Basic write with `>` (overwrites existing file):

echo "Hello, World!" >/tmp/output.txt
echo "Created file with: $(cat /tmp/output.txt)"
