#!/bin/bash
# Pattern matching with [[ ]]:

if [[ $filename = *.txt ]]; then
    echo "It's a text file"
fi
