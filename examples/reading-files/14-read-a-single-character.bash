#!/bin/bash
# Read a single character using `read -n`:

read -r -n 1 char <<<"y"

echo "You entered: $char"
