#!/bin/sh
# Practical example: Print to stderr using `printf`.

printf "Error: %s\n" "Something went wrong" >&2
