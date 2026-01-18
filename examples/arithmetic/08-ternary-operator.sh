#!/bin/sh
# Ternary operator is a shorthand way to write an if-else statement.
#
# The syntax is:
#   $((condition ? expression1 : expression2))
#
# If the condition is true, the expression1 is evaluated and returned.
# Otherwise, the expression2 is evaluated and returned.
#
# This example shows how to use the ternary operator to find the maximum of two numbers.

a=10
b=20
max=$((a > b ? a : b))
echo "Max of $a and $b: $max"
