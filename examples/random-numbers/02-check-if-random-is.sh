#!/bin/sh
# Check if $RANDOM is available:

if [ -n "$RANDOM" ]; then
  echo "Using \$RANDOM:"
  echo "  Value: $RANDOM"
  echo "  Range 1-10: $((RANDOM % 10 + 1))"
else
  echo "\$RANDOM not available (not bash)"
fi
