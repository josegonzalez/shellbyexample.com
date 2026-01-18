#!/bin/bash
# Using `=~` for regex.

haystack="The quick brown fox"
if [[ "$haystack" =~ ^The ]]; then
    echo "Starts with 'The'"
fi
