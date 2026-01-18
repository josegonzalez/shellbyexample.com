#!/bin/sh
# Progress percentage:

show_progress() {
  printf "\rProgress: %3d%%" "$1"
}
echo "Progress simulation:"
for p in 25 50 75 100; do
  show_progress "$p"
  sleep 0.2
done
printf "\n"
