#!/bin/sh
# Width and precision formatting.

echo "Width specifiers:"
printf "  |%10s|\n" "hello"  # Right-align, width 10
printf "  |%-10s|\n" "hello" # Left-align, width 10
printf "  |%10d|\n" 42       # Right-align number
printf "  |%-10d|\n" 42      # Left-align number

echo "Precision for floats:"
printf "  Default: %f\n" 3.14159265
printf "  2 decimals: %.2f\n" 3.14159265
printf "  Width + precision: %8.2f\n" 3.14159265

echo "Precision for strings (max length):"
printf "  %.5s\n" "Hello, World!" # First 5 characters
