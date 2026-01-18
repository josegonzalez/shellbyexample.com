#!/bin/sh
# Without -n, numbers sort lexicographically:

echo "Lexicographic (wrong for numbers):"
printf "10\n2\n100\n25\n1\n" | sort
