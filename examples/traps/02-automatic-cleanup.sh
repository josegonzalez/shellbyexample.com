#!/bin/sh
# Scripts often create temporary files that must be cleaned up.
# Without trap, if a script crashes or is interrupted, temp files
# leak. With trap, cleanup runs automatically on exit.

tmpfile="/tmp/demo_$$"
trap 'rm -f "$tmpfile"' EXIT

touch "$tmpfile"
echo "Created: $tmpfile"
echo "File exists: $(test -f "$tmpfile" && echo yes)"
echo "Exiting - trap will clean up..."
