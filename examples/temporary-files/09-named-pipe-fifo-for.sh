#!/bin/sh
# Named pipe (FIFO) for inter-process communication:

tmpfifo=$(mktemp -u) # -u just prints name, doesn't create
mkfifo "$tmpfifo"
echo "Created FIFO: $tmpfifo"

# Producer (background)
echo "message" >"$tmpfifo" &

# Consumer
read -r msg <"$tmpfifo"
echo "Received: $msg"

rm "$tmpfifo"
