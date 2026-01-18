#!/bin/bash
# Here-strings are particularly useful with read:

read -r first rest <<<"hello world from bash"
echo "First word: $first" # hello
