#!/bin/bash
# Bash adds `RETURN`, which runs when a function or sourced script
# returns. Useful for cleanup after function execution.

cleanup_after() {
    echo "  RETURN: function finished"
}

my_function() {
    trap cleanup_after RETURN
    echo "  Inside function"
}

echo "Calling function:"
my_function
echo "Back in main script"
