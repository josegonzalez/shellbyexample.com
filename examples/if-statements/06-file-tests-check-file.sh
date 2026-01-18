#!/bin/sh
# File tests check file properties.

if [ -f "/etc/passwd" ]; then
    echo "/etc/passwd exists and is a file"
fi

if [ -d "/tmp" ]; then
    echo "/tmp exists and is a directory"
fi
