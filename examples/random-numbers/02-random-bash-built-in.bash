#!/bin/bash
# $RANDOM - Bash built-in (0 to 32767):

echo "Bash \$RANDOM: $RANDOM"
echo "Another: $RANDOM"
echo "Range 1-100: $((RANDOM % 100 + 1))"
