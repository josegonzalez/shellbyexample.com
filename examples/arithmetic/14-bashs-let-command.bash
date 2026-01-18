#!/bin/bash
# Bash's `let` command can be used to perform arithmetic operations.

# shellcheck disable=SC2219
let "result = 5 + 3"
echo "let result: $result"

x=5
let "x++"
echo "let x: $x"

let "y = x * 2"
echo "let y: $y"
