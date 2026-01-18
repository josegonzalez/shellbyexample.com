#!/bin/sh
# Check if $RANDOM is available:

# shellcheck disable=SC3028
if [ -n "$RANDOM" ]; then
  echo "Using \$RANDOM:"
  echo "  Value: $RANDOM"
  echo "  Range 1-10: $((RANDOM % 10 + 1))"
else
  echo "\$RANDOM not available (not bash)"
fi
