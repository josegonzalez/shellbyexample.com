#!/bin/sh
# Append with file descriptor:

exec 4>>/tmp/fd.txt
echo "Appended line" >&4
exec 4>&-
cat /tmp/fd.txt
