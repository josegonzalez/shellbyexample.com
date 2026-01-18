#!/bin/sh
# Dice roll simulation:

roll_die() {
  sides="${1:-6}"
  echo $(($(od -An -tu2 -N2 /dev/urandom | tr -d ' ') % sides + 1))
}

echo "Dice rolls:"
echo "  D6: $(roll_die 6)"
echo "  D20: $(roll_die 20)"
echo "  2D6: $(($(roll_die 6) + $(roll_die 6)))"
