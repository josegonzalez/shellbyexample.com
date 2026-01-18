#!/bin/bash
# Iterate over associative array keys:

for key in "${!user[@]}"; do
    echo "$key: ${user[$key]}"
done
