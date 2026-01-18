#!/bin/bash
# Bash-specific: printf with arrays

nums=(1 2 3 4 5)
printf "Number: %d\n" "${nums[@]}"
