#!/bin/bash
# Using [[ ]] for pattern matching:

if [[ "$haystack" == *quick* ]]; then
    echo "Found quick"
fi
