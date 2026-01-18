#!/bin/sh

: # Shell scripting supports arithmetic operations
: # through several mechanisms. This example covers
: # the main ways to do math in shell scripts.

: # POSIX arithmetic expansion with $(( )):

echo "Basic arithmetic with \$(( )):"
echo "  5 + 3 = $((5 + 3))"
echo "  10 - 4 = $((10 - 4))"
echo "  6 * 7 = $((6 * 7))"
echo "  20 / 4 = $((20 / 4))"
echo "  17 % 5 = $((17 % 5))" # Modulo (remainder)

: # Variables in arithmetic (no $ needed inside):

x=10
y=3
echo "With variables (x=$x, y=$y):"
echo "  x + y = $((x + y))"
echo "  x * y = $((x * y))"
echo "  x / y = $((x / y))" # Integer division
echo "  x % y = $((x % y))"

: # Compound assignment:

count=0
count=$((count + 1))
echo "After increment: count = $count"

: # [bash]
: # Bash provides shorter increment/decrement:

# ((count++))
# ((count--))
# ((count += 5))
# ((count *= 2))
: # [/bash]

: # Comparison operators (return 1 for true, 0 for false):

a=5
b=10
echo "Comparisons (a=$a, b=$b):"
echo "  a < b: $((a < b))"
echo "  a > b: $((a > b))"
echo "  a == b: $((a == b))"
echo "  a != b: $((a != b))"
echo "  a <= b: $((a <= b))"
echo "  a >= b: $((a >= b))"

: # Logical operators:

echo "Logical operators:"
echo "  1 && 1 = $((1 && 1))"
echo "  1 && 0 = $((1 && 0))"
echo "  1 || 0 = $((1 || 0))"
echo "  !0 = $((!0))"
echo "  !1 = $((!1))"

: # Bitwise operators:

echo "Bitwise operators:"
echo "  5 & 3 = $((5 & 3))"     # AND
echo "  5 | 3 = $((5 | 3))"     # OR
echo "  5 ^ 3 = $((5 ^ 3))"     # XOR
echo "  ~5 = $((~5))"           # NOT
echo "  4 << 2 = $((4 << 2))"   # Left shift
echo "  16 >> 2 = $((16 >> 2))" # Right shift

: # Ternary operator:

max=$((a > b ? a : b))
echo "Max of $a and $b: $max"

: # Parentheses for grouping:

echo "Order of operations:"
echo "  2 + 3 * 4 = $((2 + 3 * 4))"
echo "  (2 + 3) * 4 = $(((2 + 3) * 4))"

: # Different bases:

echo "Different bases:"
echo "  Hex 0xFF = $((0xFF))"
echo "  Octal 077 = $((077))"
echo "  Binary 2#1010 = $((2#1010))" # Bash-specific

: # Using expr (older method, POSIX):

echo "Using expr:"
# shellcheck disable=SC2003
echo "  5 + 3 = $(expr 5 + 3)"
echo "  10 - 4 = $(expr 10 - 4)"
echo "  6 \* 7 = $(expr 6 \* 7)" # Note: * must be escaped
echo "  20 / 4 = $(expr 20 / 4)"

: # expr for string length and matching:

str="hello"
echo "  Length of '$str': $(expr length "$str")"

: # Floating-point arithmetic requires external tools:

echo "Floating-point with bc:"
echo "  5.5 + 3.2 = $(echo "5.5 + 3.2" | bc)"
echo "  10 / 3 = $(echo "scale=2; 10 / 3" | bc)"
echo "  sqrt(2) = $(echo "scale=4; sqrt(2)" | bc)"

: # Using awk for floating-point:

echo "Floating-point with awk:"
echo "  5.5 * 3.2 = $(awk 'BEGIN {print 5.5 * 3.2}')"
echo "  22 / 7 = $(awk 'BEGIN {printf "%.4f", 22/7}')"

: # [bash]
: # Bash's let command:

# let "result = 5 + 3"
# echo "let result: $result"

# let "x++"
# let "y = x * 2"

: # Bash's (( )) for arithmetic in conditions:

# if ((x > 5)); then
#     echo "x is greater than 5"
# fi

: # Declare integer variables:

# declare -i num
# num="5 + 3"  # Automatically evaluated
# echo "Declared int: $num"
: # [/bash]

: # Random number generation:

echo "Random numbers:"
echo "  \$RANDOM: $RANDOM"
echo "  1-100: $((RANDOM % 100 + 1))"

: # Practical examples:

: # Calculate percentage:
total=250
part=75
percent=$((part * 100 / total))
echo "Percentage: $part of $total = $percent%"

: # Loop counter:
sum=0
i=1
while [ "$i" -le 10 ]; do
  sum=$((sum + i))
  i=$((i + 1))
done
echo "Sum of 1-10: $sum"

: # Temperature conversion:
celsius=25
fahrenheit=$(echo "scale=1; $celsius * 9/5 + 32" | bc)
echo "Temperature: ${celsius}C = ${fahrenheit}F"

: # Powers (bash only has ** operator, use bc for POSIX):
base=2
exp=10
power=$(echo "$base ^ $exp" | bc)
echo "Power: $base^$exp = $power"

echo "Arithmetic examples complete"
