#!/bin/sh
# Random boolean:

random_bool() {
  [ $(($(od -An -tu1 -N1 /dev/urandom | tr -d ' ') % 2)) -eq 1 ]
}

echo "Random booleans:"
for _ in 1 2 3 4 5; do
  if random_bool; then
    printf "  true\n"
  else
    printf "  false\n"
  fi
done
