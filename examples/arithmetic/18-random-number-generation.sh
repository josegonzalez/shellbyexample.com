#!/bin/sh
# Random number generation:

echo "Random numbers:"
echo "  \$RANDOM: $RANDOM"
echo "  1-100: $((RANDOM % 100 + 1))"
