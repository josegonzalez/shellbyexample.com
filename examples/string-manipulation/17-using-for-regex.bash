#!/bin/bash
# Using =~ for regex:

if [[ "$haystack" =~ ^The ]]; then
    echo "Starts with 'The'"
fi
