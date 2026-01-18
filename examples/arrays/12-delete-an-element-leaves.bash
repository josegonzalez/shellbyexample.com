#!/bin/bash
# Delete an element (leaves a gap in indices).

fruits=("apple" "banana" "cherry" "date")
unset 'fruits[2]'
echo "After unset [2]: ${fruits[*]}"
echo "Indices now: ${!fruits[*]}"
