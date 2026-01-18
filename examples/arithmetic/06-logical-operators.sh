#!/bin/sh
# Logical operators:

echo "Logical operators:"
echo "  1 && 1 = $((1 && 1))"
echo "  1 && 0 = $((1 && 0))"
echo "  1 || 0 = $((1 || 0))"
echo "  !0 = $((!0))"
echo "  !1 = $((!1))"
