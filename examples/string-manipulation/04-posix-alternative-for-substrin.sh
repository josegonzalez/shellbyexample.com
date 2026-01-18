#!/bin/sh
# POSIX alternative for substrings uses `expr` or `cut`.

echo "POSIX substring with expr:"
text="Hello, World!"
echo "  First 5: $(expr "$text" : '\(.....\)')"
echo "  Using cut: $(echo "$text" | cut -c1-5)"
