#!/bin/sh
# Producer-consumer pattern:

echo "Producer-consumer:"
producer_consumer() {
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
}
producer_consumer
