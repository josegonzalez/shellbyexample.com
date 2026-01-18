#!/bin/bash
# Bash's `$(( ))` can be used for arithmetic in conditions.

if ((x > 5)); then
    echo "x is greater than 5"
fi
