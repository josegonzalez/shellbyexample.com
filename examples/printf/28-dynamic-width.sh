#!/bin/sh
# Practical example: Dynamic width using `printf`.

width=20
printf "%*s\n" "$width" "right-aligned"
printf "%-*s\n" "$width" "left-aligned"
