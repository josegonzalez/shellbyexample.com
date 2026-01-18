#!/bin/sh
# You can also use curly braces for clarity,
# especially when the variable name could be ambiguous.
# Without braces, this would try to find a variable
# named `file_2024` which doesn't exist.

file="report"
echo "${file}_2024.txt"
