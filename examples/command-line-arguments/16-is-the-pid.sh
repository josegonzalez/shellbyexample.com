#!/bin/sh
# `$!` is the PID of the last background command:

sleep 1 &
echo "Background PID: $!"
wait
