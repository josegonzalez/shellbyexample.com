#!/bin/bash
# Bash can store directly with -v flag:

printf -v myvar "Value: %05d" 42
echo "Stored: $myvar"
