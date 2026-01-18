#!/bin/sh
# More random numbers

echo "  Multiple random numbers:"
awk 'BEGIN { srand(); for(i=1; i<=5; i++) print int(rand() * 100) + 1 }'
