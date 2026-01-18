#!/bin/sh
# Practical example: Leading zeros for file numbering using `printf`.

echo "File numbering:"
for i in 1 2 3 10 100; do
  printf "  file_%03d.txt\n" "$i"
done
