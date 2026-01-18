#!/bin/bash
# Using parameter expansion:

padded="   hello world   "
trimmed="${padded#"${padded%%[![:space:]]*}"}"
trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
echo "Padded: '$padded'"
echo "Trimmed: '$trimmed'"
