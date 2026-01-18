#!/bin/bash
# Array slicing: `${array[@]:start:length}`

fruits=("apple" "banana" "cherry" "date")
echo "First three: ${fruits[*]:0:3}"
echo "From index 2: ${fruits[*]:2}"
