#!/bin/sh
# Read file descriptor directly:

echo "Using file descriptor:"
exec 3</tmp/sample.txt
read -r first_line <&3
echo "  First line: $first_line"
read -r second_line <&3
echo "  Second line: $second_line"
exec 3<&- # Close file descriptor
