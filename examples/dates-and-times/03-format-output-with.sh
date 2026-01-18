#!/bin/sh
# Format output with + and format specifiers:

echo "Formatted outputs:"
echo "  ISO format: $(date '+%Y-%m-%d')"
echo "  US format: $(date '+%m/%d/%Y')"
echo "  Time: $(date '+%H:%M:%S')"
echo "  Full: $(date '+%Y-%m-%d %H:%M:%S')"
