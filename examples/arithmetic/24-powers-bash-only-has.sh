#!/bin/sh
# Powers (bash only has ** operator, use bc for POSIX):

base=2
exp=10
power=$(echo "$base ^ $exp" | bc)
echo "Power: $base^$exp = $power"

echo "Arithmetic examples complete"
