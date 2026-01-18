#!/bin/bash
# Capture groups:

if [[ "user@example.com" =~ ^(.+)@(.+)$ ]]; then
    echo "User: ${BASH_REMATCH[1]}"
    echo "Domain: ${BASH_REMATCH[2]}"
fi
