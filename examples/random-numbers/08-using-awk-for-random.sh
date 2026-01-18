#!/bin/sh
# Using awk for random numbers:

echo "Using awk:"
awk 'BEGIN { srand(); print int(rand() * 100) + 1 }'
