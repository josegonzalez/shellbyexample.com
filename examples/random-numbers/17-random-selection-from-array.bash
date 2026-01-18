#!/bin/bash
# Random selection from array:

fruits=("apple" "banana" "cherry" "date" "elderberry")
random_index=$((RANDOM % ${#fruits[@]}))
echo "Random fruit: ${fruits[$random_index]}"
