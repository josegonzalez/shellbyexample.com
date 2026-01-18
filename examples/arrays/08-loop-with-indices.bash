#!/bin/bash
# Loop with indices.

echo "With indices:"
for i in "${!fruits[@]}"; do
    echo "  [$i] = ${fruits[$i]}"
done
