#!/bin/bash
# Check if a key exists:

if [[ -v user[name] ]]; then
    echo "name key exists"
fi
