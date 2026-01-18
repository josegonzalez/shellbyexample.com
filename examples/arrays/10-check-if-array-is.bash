#!/bin/bash
# Check if array is empty.

empty_array=()
if [ ${#empty_array[@]} -eq 0 ]; then
    echo "Array is empty"
fi
