#!/bin/sh
# Store printf output in variable:

result=$(printf "Value: %05d" 42)
echo "Stored: $result"
