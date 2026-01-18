#!/bin/sh
# Coin flip:

coin_flip() {
  if [ $(($(od -An -tu1 -N1 /dev/urandom | tr -d ' ') % 2)) -eq 0 ]; then
    echo "heads"
  else
    echo "tails"
  fi
}

echo "Coin flips: $(coin_flip) $(coin_flip) $(coin_flip)"

echo "Random numbers examples complete"
