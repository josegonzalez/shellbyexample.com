#!/bin/sh
# Store `printf` output in a variable.

result=$(printf "Value: %05d" 42)
echo "Stored: $result"
