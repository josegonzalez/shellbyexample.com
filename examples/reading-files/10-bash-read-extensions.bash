#!/bin/bash
# Bash extends the `read` builtin with useful flags
# not available in POSIX sh:
#
# - `read -t N` sets a timeout (seconds)
# - `read -n N` reads exactly N characters
# - `read -p "text"` displays a prompt
#
# Bash also provides `mapfile` (alias `readarray`) to
# load an entire file into an array in one step.

# read -t: timeout after N seconds
echo "=== read -t (timeout) ==="
read -r -t 5 input <<<"hello from timeout"
echo "  Got: $input"

# read -n: read exactly N characters
echo ""
echo "=== read -n (single character) ==="
read -r -n 1 char <<<"y"
echo ""
echo "  Got: $char"

# read -p: display a prompt string
echo ""
echo "=== read -p (prompt) ==="
read -r -p "Enter value: " value <<<"42"
echo "  Got: $value"

# mapfile loads a whole file into an array at once —
# faster and simpler than a while-read loop
echo ""
echo "=== mapfile (array loading) ==="
printf "alpha\nbeta\ngamma\n" >/tmp/greek.txt
mapfile -t lines </tmp/greek.txt
echo "  Count: ${#lines[@]}"
echo "  First: ${lines[0]}"
echo "  Last:  ${lines[2]}"
