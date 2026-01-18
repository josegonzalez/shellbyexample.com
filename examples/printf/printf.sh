#!/bin/sh

: # The `printf` command provides formatted output,
: # similar to printf in C. It's more portable and
: # powerful than echo for complex formatting.

: # Basic printf syntax: printf FORMAT [ARGUMENTS...]

printf "Hello, World!\n"

: # Unlike echo, printf doesn't add a newline automatically.
: # Use \n to add newlines.

printf "Line 1\n"
printf "Line 2\n"

: # Format specifiers:

: # %s - String
printf "String: %s\n" "hello"

: # %d - Decimal integer
printf "Integer: %d\n" 42

: # %f - Floating point
printf "Float: %f\n" 3.14159

: # %e - Scientific notation
printf "Scientific: %e\n" 1234.5

: # %x - Hexadecimal
printf "Hex: %x\n" 255

: # %o - Octal
printf "Octal: %o\n" 64

: # %c - Single character
printf "Character: %c\n" "A"

: # %% - Literal percent sign
printf "Percent: 100%%\n"

: # Width and precision:

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

: # Zero-padding:

printf "Zero-padded: %05d\n" 42
printf "Zero-padded: %08.2f\n" 3.14

: # Multiple arguments:

printf "%s is %d years old\n" "Alice" 30
printf "%s is %d years old\n" "Bob" 25

: # Arguments cycle through format:

printf "%s\n" "first" "second" "third"
printf "%s %s\n" "a" "1" "b" "2" "c" "3"

: # Escape sequences:

echo "Escape sequences:"
printf "  Tab:\tafter tab\n"
printf "  Newline:\nafter newline\n"
printf "  Backslash: \\\\\n"
printf "  Single quote: \\'\n"
printf "  Bell: \a(beep)\n"

: # Hex and octal escape codes:

printf "  Hex (41 = A): \x41\n"
printf "  Octal (101 = A): \101\n"

: # Store printf output in variable:

result=$(printf "Value: %05d" 42)
echo "Stored: $result"

: # [bash]
: # Bash can store directly with -v flag:
# printf -v myvar "Value: %05d" 42
# echo "Stored: $myvar"
: # [/bash]

: # Practical examples:

: # Create a table:

printf "\n%-15s %8s %10s\n" "Name" "Age" "Salary"
printf "%-15s %8d %10.2f\n" "Alice Smith" 30 75000
printf "%-15s %8d %10.2f\n" "Bob Johnson" 25 65000
printf "%-15s %8d %10.2f\n" "Carol White" 35 85000

: # Format currency:

format_currency() {
  printf "$%'.2f\n" "$1"
}
format_currency 1234567.89

: # Leading zeros for file numbering:

echo "File numbering:"
for i in 1 2 3 10 100; do
  printf "  file_%03d.txt\n" "$i"
done

: # Progress percentage:

show_progress() {
  printf "\rProgress: %3d%%" "$1"
}
echo "Progress simulation:"
for p in 25 50 75 100; do
  show_progress "$p"
  sleep 0.2
done
printf "\n"

: # Color output (ANSI escape codes):

printf "\033[31mRed text\033[0m\n"
printf "\033[32mGreen text\033[0m\n"
printf "\033[1mBold text\033[0m\n"
printf "\033[4mUnderlined\033[0m\n"

: # Format date components:

year=2024
month=3
day=15
printf "Date: %04d-%02d-%02d\n" "$year" "$month" "$day"

: # Dynamic width:

width=20
printf "%*s\n" "$width" "right-aligned"
printf "%-*s\n" "$width" "left-aligned"

: # Print to stderr:

printf "Error: %s\n" "Something went wrong" >&2

: # Repeat character N times:

printf '=%.0s' $(seq 1 40)
printf '\n'

: # [bash]
: # Bash-specific: printf with arrays
# nums=(1 2 3 4 5)
# printf "Number: %d\n" "${nums[@]}"
: # [/bash]

: # Common patterns:

# Debug output
debug() {
  printf "[DEBUG] %s: %s\n" "$(date +%H:%M:%S)" "$*" >&2
}
debug "Starting process"

# Log with timestamp
log() {
  printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}
log "Application started"

echo "Printf examples complete"
