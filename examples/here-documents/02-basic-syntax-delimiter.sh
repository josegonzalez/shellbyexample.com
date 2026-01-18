#!/bin/sh
# Basic syntax: `<<DELIMITER ... DELIMITER`
#
# The delimiter can be any word (`EOF` is common).
# Variables like `$HOME` are expanded.

cat << EOF
This is a here-document.
It can span multiple lines.
Variables like $HOME are expanded.
EOF
