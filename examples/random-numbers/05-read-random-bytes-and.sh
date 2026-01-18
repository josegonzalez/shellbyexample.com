#!/bin/sh
# Read random bytes and convert to number

rand=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
echo "  Random 32-bit: $rand"
