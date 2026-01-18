#!/bin/sh
# Canonical path (resolve symlinks):

if command -v realpath >/dev/null 2>&1; then
    echo "Canonical /usr/bin: $(realpath /usr/bin)"
elif command -v readlink >/dev/null 2>&1; then
    echo "Canonical /usr/bin: $(readlink -f /usr/bin 2>/dev/null || echo '/usr/bin')"
fi
