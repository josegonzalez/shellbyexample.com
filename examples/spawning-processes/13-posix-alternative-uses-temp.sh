#!/bin/sh
# POSIX alternative uses temp files or named pipes:

echo "POSIX diff comparison:"
tmpf1=$(mktemp)
tmpf2=$(mktemp)
ls /bin >"$tmpf1"
ls /usr/bin >"$tmpf2"
diff "$tmpf1" "$tmpf2" | head -5
rm "$tmpf1" "$tmpf2"
