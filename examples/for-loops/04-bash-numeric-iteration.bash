#!/bin/bash
# Bash provides two convenient syntaxes for numeric
# iteration that don't require external commands like `seq`.
#
# Brace expansion `{START..END}` generates a sequence at
# parse time. You can optionally add a step: `{START..END..STEP}`.
# Note: brace expansion happens before variable expansion,
# so you cannot use variables in the range.
#
# C-style for loops `((init; condition; increment))` work
# like for loops in C, Java, or JavaScript. The three
# parts are: initialization, continue condition, and
# increment expression. This syntax supports variables.

echo "Brace expansion {1..5}:"
for n in {1..5}; do
    echo "  $n"
done

echo ""
echo "Brace expansion with step {1..10..2}:"
for n in {1..10..2}; do
    echo "  $n"
done

echo ""
echo "C-style for loop:"
for ((i = 1; i <= 5; i++)); do
    echo "  $i"
done

echo ""
echo "C-style counting down:"
for ((i = 3; i >= 1; i--)); do
    echo "  $i"
done
