#!/bin/sh
# Check if string contains substring:

haystack="The quick brown fox"
needle="quick"

case "$haystack" in
    *"$needle"*) echo "'$haystack' contains '$needle'" ;;
    *) echo "'$haystack' does not contain '$needle'" ;;
esac
