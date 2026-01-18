#!/bin/bash
# Using parameter expansion (bash):

trimmed="${padded#"${padded%%[![:space:]]*}"}"
trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
