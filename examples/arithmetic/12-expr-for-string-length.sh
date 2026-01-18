#!/bin/sh
# `expr` for string length and matching:

str="hello"
# shellcheck disable=SC2308
echo "  Length of '$str': $(expr length "$str")"
