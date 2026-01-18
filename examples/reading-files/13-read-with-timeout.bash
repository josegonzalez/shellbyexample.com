#!/bin/bash
# Read with timeout using `read -t`:

read -r -t 5 input <<<"hello" # Wait 5 seconds max

echo "Input: $input"
