#!/bin/sh
# To support `-h`, add `h` to your optstring and handle it
# in your case statement. Use `exit 0` (or `return 0` in a
# function) after showing help to stop execution.
#
# A here-document is a clean way to format multi-line help text.

show_help() {
    cat <<EOF
Usage: greet [-v] [-h]

Options:
  -v    Enable verbose output
  -h    Show this help message

Example:
  greet -v
EOF
}

demo() {
    verbose=false
    OPTIND=1
    while getopts "vh" opt; do
        case "$opt" in
            v) verbose=true ;;
            h)
                show_help
                return 0
                ;;
        esac
    done
    echo "Running with verbose=$verbose"
}

echo "With -h flag:"
demo -h

echo ""
echo "With -v flag:"
demo -v
