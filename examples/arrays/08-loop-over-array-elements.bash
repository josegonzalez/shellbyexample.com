#!/bin/bash
# Loop over array elements.

echo "Iterating over fruits:"
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done
