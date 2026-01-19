#!/bin/bash
# Bash extends case with fall-through operators:
# - `;&` falls through to the next block unconditionally
# - `;;&` continues testing remaining patterns
#
# These are Bash-specific and not POSIX-compliant.

grade="B"

echo "Using ;& (unconditional fall-through):"
case $grade in
    A)
        echo "  Excellent!"
        ;&
    B)
        echo "  Good job!"
        ;&
    C)
        echo "  You passed."
        ;;
    *)
        echo "  Needs improvement."
        ;;
esac

echo ""
echo "Using ;;& (continue testing patterns):"
value="hello"
case $value in
    hello)
        echo "  Matched: hello"
        ;;&
    h*)
        echo "  Matched: h*"
        ;;&
    *o)
        echo "  Matched: *o"
        ;;
esac
