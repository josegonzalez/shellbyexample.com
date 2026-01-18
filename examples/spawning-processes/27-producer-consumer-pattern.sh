#!/bin/sh
# This example shows how to use a named pipe to implement
# the producer-consumer pattern more generally. The same
# patter used in the previous example is used here.

fifo=$(mktemp -u)
mkfifo "$fifo"
trap 'rm -f "$fifo"' EXIT

# Producer
(
  for i in 1 2 3; do
    echo "item$i"
    sleep 0.5
  done
) >"$fifo" &
producer=$!

# Consumer
while read -r item; do
  echo "Consumed: $item"
done <"$fifo"

wait $producer
