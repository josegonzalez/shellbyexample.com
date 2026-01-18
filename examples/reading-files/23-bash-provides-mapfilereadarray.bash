#!/bin/bash
# Bash provides mapfile/readarray for reading into arrays:

mapfile -t lines < /tmp/sample.txt
echo "Number of lines: ${#lines[@]}"
echo "First line: ${lines[0]}"
