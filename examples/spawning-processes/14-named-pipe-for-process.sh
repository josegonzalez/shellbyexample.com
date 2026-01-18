#!/bin/sh
# Named pipe for process communication:

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
