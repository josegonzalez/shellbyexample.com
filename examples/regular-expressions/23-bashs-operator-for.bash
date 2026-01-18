#!/bin/bash
# Bash's =~ operator for regex matching:

if [[ "hello123" =~ ^hello[0-9]+$ ]]; then
    echo "Matches!"
    echo "Full match: ${BASH_REMATCH[0]}"
fi
