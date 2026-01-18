#!/bin/bash
# Bash can store `printf` output directly with the `-v` flag.

printf -v myvar "Value: %05d" 42
echo "Stored: $myvar"
