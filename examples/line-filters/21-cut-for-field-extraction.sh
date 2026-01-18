#!/bin/sh
# cut for field extraction:

echo "Extract fields with cut:"
echo "name:age:city" | cut -d: -f2
