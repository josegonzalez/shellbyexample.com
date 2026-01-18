#!/bin/sh
# Version number sort with -V:

echo "Version sort:"
printf "v1.10\nv1.2\nv1.9\nv2.0\n" | sort -V 2>/dev/null || echo "  (requires GNU sort)"
