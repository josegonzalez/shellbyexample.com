#!/bin/bash
# Loop over array elements.

fruits=("apple" "banana" "cherry" "date")
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done
