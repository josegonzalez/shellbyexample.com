#!/bin/sh
# Weighted random selection:

weighted_random() {
  # Weights: apple=50%, banana=30%, cherry=20%
  roll=$(($(od -An -tu1 -N1 /dev/urandom | tr -d ' ') % 100))
  if [ "$roll" -lt 50 ]; then
    echo "apple"
  elif [ "$roll" -lt 80 ]; then
    echo "banana"
  else
    echo "cherry"
  fi
}

echo "Weighted random (5 trials):"
for _ in 1 2 3 4 5; do
  echo "  $(weighted_random)"
done
