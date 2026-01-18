#!/bin/sh
# Discard output:

echo "Discarding output:"
ls /nonexistent 2>/dev/null # Discard stderr
echo "  Stderr discarded (no error shown)"
