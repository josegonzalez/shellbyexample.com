#!/bin/sh
# For arguments beyond `$9`, you must use braces: `${10}`,
# `${11}`, etc. Without braces, `$10` is interpreted as
# `$1` followed by the literal character `0`.
#
# This rarely comes up since most scripts don't take 10+
# positional arguments, but it's important to know.

set -- a b c d e f g h i j k l

echo "Without braces (wrong):"
echo "  \$10 = $10  (actually \$1 + '0')"

echo ""
echo "With braces (correct):"
echo "  \${10} = ${10}"
echo "  \${11} = ${11}"
echo "  \${12} = ${12}"
