#!/bin/bash
# Bash arrays store multiple values in a single variable.
# Use `"${array[@]}"` to expand all elements for iteration,
# preserving elements that contain spaces.
#
# This is similar to `"$@"` for positional parameters.
# The quotes and `[@]` together ensure each element is
# treated as a separate item.
#
# Note: Arrays are a Bash feature and are not available
# in POSIX sh.

fruits=("apple" "banana" "cherry pie")

echo "Iterating over array elements:"
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done

echo ""
echo "Array indices are also available:"
for i in "${!fruits[@]}"; do
    echo "  index $i: ${fruits[$i]}"
done
