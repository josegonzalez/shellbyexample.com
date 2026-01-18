#!/bin/sh
# You can also use backticks, but `$()` is preferred
# because it's easier to nest and read.

current_user=`whoami`
echo "Current user: $current_user"
