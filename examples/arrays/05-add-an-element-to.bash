#!/bin/bash
# Add an element to the end.

fruits=("apple" "banana" "cherry" "date")
fruits+=("elderberry")
echo "After adding: ${fruits[*]}"
