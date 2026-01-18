#!/bin/bash
# Bash provides the `local` keyword for function-scoped
# variables that don't affect the global namespace:

calculate() {
    local result=0
    local i
    for i in "$@"; do
        result=$((result + i))
    done
    echo "$result"
}

result="global"
sum=$(calculate 1 2 3 4 5)
echo "Sum: $sum"          # Sum: 15
echo "Result: $result"    # Result: global (unchanged)
