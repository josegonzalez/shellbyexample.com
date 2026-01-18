#!/bin/sh
# Check if a variable is set:

if [ -n "$HOME" ]; then
    echo "HOME is set to: $HOME"
fi

if [ -z "$UNDEFINED_VAR" ]; then
    echo "UNDEFINED_VAR is not set"
fi
