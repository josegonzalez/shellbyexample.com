#!/bin/bash
# Get array indices with `${!array[@]}`, and loop with indices.

fruits=(apple banana cherry)

echo "Indices: ${!fruits[*]}"

echo "With indices:"
for i in "${!fruits[@]}"; do
    echo "  [$i] = ${fruits[$i]}"
done
