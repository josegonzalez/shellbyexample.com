#!/bin/bash
# Declare integer variables with `declare -i` to automatically evaluate arithmetic expressions.

declare -i num
num="5 + 3" # Automatically evaluated
echo "Declared int: $num"
