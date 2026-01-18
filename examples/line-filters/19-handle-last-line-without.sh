#!/bin/sh
# Handle last line without newline:

echo "Handle missing final newline:"
printf "line1\nline2" | while IFS= read -r line || [ -n "$line" ]; do
    echo "  [$line]"
done
