#!/bin/bash
# Using parameter expansion:

trimmed="${padded#"${padded%%[![:space:]]*}"}"
trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
