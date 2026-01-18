#!/bin/sh
# Here-documents (heredocs) let you include multi-line
# text directly in your script. They're great for
# embedding configuration files, SQL queries, or
# help text.
#
# Basic syntax: `<<DELIMITER ... DELIMITER`
#
# The delimiter can be any word (`EOF` is common).
# Variables like `$HOME` are expanded.

cat << EOF
This is a here-document.
It can span multiple lines.
Variables like $HOME are expanded.
EOF
