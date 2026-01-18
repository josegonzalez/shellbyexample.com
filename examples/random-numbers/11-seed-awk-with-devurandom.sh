#!/bin/sh
# Seed awk with /dev/urandom for better randomness:

seed=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
echo "Seeded awk:"
awk -v seed="$seed" 'BEGIN { srand(seed); print int(rand() * 100) + 1 }'
