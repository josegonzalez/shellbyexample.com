#!/bin/sh
# Locale affects sort order:

echo "Locale-independent sort (C locale):"
printf "Étoile\nApple\néclair\nBanana\n" | LC_ALL=C sort
