#!/bin/sh
# Using shuf for random selection:

if command -v shuf >/dev/null 2>&1; then
  echo "Using shuf:"

  # Random line from input
  echo "  Random fruit:"
  printf "apple\nbanana\ncherry\norange\n" | shuf -n1

  # Multiple random selections
  echo "  Two random fruits:"
  printf "apple\nbanana\ncherry\norange\n" | shuf -n2

  # Random number from range
  echo "  Random number 1-10: $(shuf -i 1-10 -n1)"

  # Shuffle a list
  echo "  Shuffled list:"
  printf "1\n2\n3\n4\n5\n" | shuf
elif command -v gshuf >/dev/null 2>&1; then
  # macOS with coreutils
  echo "Using gshuf:"
  echo "  Random number 1-10: $(gshuf -i 1-10 -n1)"
fi
