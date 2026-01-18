#!/bin/sh
# Source a script (run in current shell):

echo "source demo:"
tmpscript=$(mktemp)
echo 'SOURCED_VAR="from sourced script"' >"$tmpscript"
. "$tmpscript" # POSIX way to source
echo "SOURCED_VAR: $SOURCED_VAR"
rm "$tmpscript"

echo "Spawning processes examples complete"
