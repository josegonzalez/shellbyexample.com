#!/bin/sh
# Script's own directory:

echo "Script location:"
echo "  \$0: $0"

# Get script directory (works for sourced scripts too)
script_dir() {
    # Try readlink first for symlinks
    if command -v readlink > /dev/null 2>&1; then
        dir=$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")")
    else
        dir=$(dirname "$0")
    fi
    # Make absolute
    cd "$dir" 2>/dev/null && pwd || echo "$dir"
}
