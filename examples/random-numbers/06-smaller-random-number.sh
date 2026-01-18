#!/bin/sh
# Smaller random number

rand=$(od -An -tu2 -N2 /dev/urandom | tr -d ' ')
echo "  Random 16-bit: $rand"
