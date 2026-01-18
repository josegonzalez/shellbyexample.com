#!/bin/sh
# At least 6 X's are required for the random suffix.
# This ensures sufficient randomness in the filename.

tmpfile=$(mktemp /tmp/data.XXXXXX)
echo "6 X's works: $tmpfile"
rm "$tmpfile"

tmpfile=$(mktemp /tmp/longer.XXXXXXXXXX)
echo "More X's also works: $tmpfile"
rm "$tmpfile"
