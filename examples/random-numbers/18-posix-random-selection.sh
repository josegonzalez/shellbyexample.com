#!/bin/sh
# POSIX random selection:

random_word() {
  words="$1"
  count=$(echo "$words" | wc -w)
  index=$(($(od -An -tu2 -N2 /dev/urandom | tr -d ' ') % count + 1))
  echo "$words" | cut -d' ' -f"$index"
}

echo "POSIX random selection:"
echo "  Random fruit: $(random_word "apple banana cherry date")"
