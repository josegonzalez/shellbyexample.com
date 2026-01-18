#!/bin/bash
# Regex matching with `=~` can be used for more complex string matching.

email="test@example.com"
# this regex is not comprehesive
# and merely used for demonstration purposes
if [[ $email =~ ^[a-z]+@[a-z]+\.[a-z]+$ ]]; then
    echo "Valid email format"
fi
