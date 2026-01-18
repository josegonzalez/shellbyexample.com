#!/bin/sh
# Combining multiple signals:

(
    trap 'echo "  Interrupted or terminated"' INT TERM
    echo "  Trapping both INT and TERM"
)
