#!/bin/bash
# Regex matching with =~:

if [[ $email =~ ^[a-z]+@[a-z]+\.[a-z]+$ ]]; then
    echo "Valid email format"
fi
