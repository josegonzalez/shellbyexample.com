#!/bin/sh
# Human-readable sizes with -h:

echo "Human-readable sizes:"
printf "1K\n10M\n500K\n1G\n100\n" | sort -h
