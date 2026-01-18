#!/bin/sh
# Here-documents work great for multi-line variables.

help_text=$(cat << 'EOF'
Usage: myscript [options] <file>

Options:
  -h, --help     Show this help message
  -v, --verbose  Enable verbose output
  -o FILE        Output to FILE

Examples:
  myscript input.txt
  myscript -v -o output.txt input.txt
EOF
)

echo "$help_text"
