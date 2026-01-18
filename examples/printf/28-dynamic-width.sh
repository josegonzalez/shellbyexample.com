#!/bin/sh
# Dynamic width:

width=20
printf "%*s\n" "$width" "right-aligned"
printf "%-*s\n" "$width" "left-aligned"
