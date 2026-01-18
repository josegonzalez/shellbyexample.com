#!/bin/sh
# Named pipes can be used for inter-process communication.
#
# The `mktemp -u` command creates a temporary file name,
# and the `mkfifo` command creates a named pipe. The
# subshell then writes to the named pipe, and the main
# shell - or another process - reads from the named pipe.

echo "Named pipe communication:"
fifo=$(mktemp -u)
mkfifo "$fifo"

# Producer
(echo "Hello from producer" >"$fifo") &
producer_pid=$!

# Consumer
message=$(cat "$fifo")
echo "Received: $message"

wait $producer_pid
rm "$fifo"
