#!/bin/sh
# Get absolute path with realpath (GNU) or readlink:

echo "Absolute paths:"
# realpath resolves symlinks
realpath . 2>/dev/null || readlink -f . 2>/dev/null || pwd
