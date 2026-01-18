#!/bin/sh
# Sort IP addresses:

echo "Sort IP addresses:"
printf "192.168.1.10\n192.168.1.2\n10.0.0.1\n" | sort -t. -k1,1n -k2,2n -k3,3n -k4,4n
