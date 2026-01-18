#!/bin/bash
# Using `[[ ]]` for pattern matching.

haystack="The quick brown fox"
if [[ "$haystack" == *quick* ]]; then
    echo "Found quick"
else
    echo "Not found"
fi
