#!/bin/sh
# Write with file descriptor:

exec 3>/tmp/fd.txt
echo "Line 1" >&3
echo "Line 2" >&3
exec 3>&- # Close the file descriptor
echo "File descriptor write:"
cat /tmp/fd.txt
