#!/bin/sh
# Random number in range using /dev/urandom:

random_range() {
  min=$1
  max=$2
  range=$((max - min + 1))
  rand=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
  echo $((rand % range + min))
}

echo "Random in range 1-100: $(random_range 1 100)"
echo "Random in range 50-60: $(random_range 50 60)"
