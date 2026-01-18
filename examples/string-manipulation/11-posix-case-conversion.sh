#!/bin/sh
# POSIX case conversion:

word="Hello World"
echo "POSIX case conversion with tr:"
echo "  Uppercase: $(echo "$word" | tr '[:lower:]' '[:upper:]')"
echo "  Lowercase: $(echo "$word" | tr '[:upper:]' '[:lower:]')"
