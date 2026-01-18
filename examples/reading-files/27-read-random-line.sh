#!/bin/sh
# Read random line:

echo "Random line:"
shuf -n 1 /tmp/sample.txt 2>/dev/null \
  || awk 'BEGIN{srand()} {lines[NR]=$0} END{print lines[int(rand()*NR)+1]}' /tmp/sample.txt
