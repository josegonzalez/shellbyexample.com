#!/bin/bash
# Set a specific index.

fruits=("apple" "banana" "cherry" "date")
fruits[1]="blueberry"
echo "After replacing: ${fruits[*]}"
