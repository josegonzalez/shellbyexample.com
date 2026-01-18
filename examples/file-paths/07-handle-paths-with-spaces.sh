#!/bin/sh
# Handle paths with spaces:

spacepath="/home/user/my documents/my file.txt"
echo "Path with spaces:"
echo "  Dir: $(dirname "$spacepath")"
echo "  Name: $(basename "$spacepath")"
