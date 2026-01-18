#!/bin/sh
# An alternative to a named pipe is to use a temp file.
#
# A named pipe is a more efficient way to communicate between processes
# as the data does not get written to disk and data is consumed when read,
# while a temporary file persists past the end of the script (if not cleaned up)
# and can have it's data read by multiple processes.

tmpfile=$(mktemp)
(
    sleep 1
    echo "Background result" >"$tmpfile"
) &
pid=$!

echo "Doing other work..."
sleep 0.5
echo "Still working..."

wait $pid
result=$(cat "$tmpfile")
rm "$tmpfile"
echo "Got result: $result"
