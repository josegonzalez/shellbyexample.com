#!/bin/sh
# basename can strip a suffix:

echo "Without .txt: $(basename "$path" .txt)"
