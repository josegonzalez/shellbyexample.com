#!/bin/sh
# Multiple sort keys:

echo "Sort by age, then name:"
sort -k2,2n -k1,1 /tmp/data.txt
