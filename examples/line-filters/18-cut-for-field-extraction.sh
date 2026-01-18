#!/bin/sh
# `cut` is a simple method for extracting fields from a line.

echo "Extract fields with cut:"
echo "name:age:city" | cut -d: -f2
