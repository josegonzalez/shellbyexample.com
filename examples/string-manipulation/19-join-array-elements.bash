#!/bin/bash
# Join array elements:

fruits=("apple" "banana" "cherry")
IFS=','
echo "Joined: ${fruits[*]}"
unset IFS
