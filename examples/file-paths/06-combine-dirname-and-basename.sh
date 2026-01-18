#!/bin/sh
# Combine `dirname` and `basename`:

fullpath="/var/log/syslog"
dir=$(dirname "$fullpath")
name=$(basename "$fullpath")
echo "Dir: $dir, Name: $name"
