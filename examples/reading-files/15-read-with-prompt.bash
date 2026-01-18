#!/bin/bash
# Read with a prompt using `read -p`:

read -r -p "Enter value: " value <<<"42"

echo "You entered: $value"
