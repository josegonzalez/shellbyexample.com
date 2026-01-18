#!/bin/sh

: # Shell provides several ways to generate random numbers,
: # from the simple $RANDOM variable to cryptographically
: # secure sources.

: # [bash]
: # $RANDOM - Bash built-in (0 to 32767):
# echo "Bash \$RANDOM: $RANDOM"
# echo "Another: $RANDOM"
# echo "Range 1-100: $((RANDOM % 100 + 1))"
: # [/bash]

: # Check if $RANDOM is available:

if [ -n "$RANDOM" ]; then
  echo "Using \$RANDOM:"
  echo "  Value: $RANDOM"
  echo "  Range 1-10: $((RANDOM % 10 + 1))"
else
  echo "\$RANDOM not available (not bash)"
fi

: # Using /dev/urandom (cryptographically secure):

echo "Using /dev/urandom:"

: # Read random bytes and convert to number
rand=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
echo "  Random 32-bit: $rand"

: # Smaller random number
rand=$(od -An -tu2 -N2 /dev/urandom | tr -d ' ')
echo "  Random 16-bit: $rand"

: # Random number in range using /dev/urandom:

random_range() {
  min=$1
  max=$2
  range=$((max - min + 1))
  rand=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
  echo $((rand % range + min))
}

echo "Random in range 1-100: $(random_range 1 100)"
echo "Random in range 50-60: $(random_range 50 60)"

: # Using awk for random numbers:

echo "Using awk:"
awk 'BEGIN { srand(); print int(rand() * 100) + 1 }'

: # More random numbers
echo "  Multiple random numbers:"
awk 'BEGIN { srand(); for(i=1; i<=5; i++) print int(rand() * 100) + 1 }'

: # Note: awk's srand() with no argument uses time,
: # so rapid calls may produce same sequence.

: # Seed awk with /dev/urandom for better randomness:

seed=$(od -An -tu4 -N4 /dev/urandom | tr -d ' ')
echo "Seeded awk:"
awk -v seed="$seed" 'BEGIN { srand(seed); print int(rand() * 100) + 1 }'

: # Using shuf for random selection:

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

: # Alternative to shuf using sort -R:

echo "Using sort -R:"
printf "a\nb\nc\nd\ne\n" | sort -R | head -1

: # Random string generation:

echo "Random strings:"

# Alphanumeric string
randstr=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | head -c 16)
echo "  Alphanumeric (16): $randstr"

# Hex string
randhex=$(od -An -tx1 -N8 /dev/urandom | tr -d ' \n')
echo "  Hex (16 chars): $randhex"

# Base64 string
if command -v base64 >/dev/null 2>&1; then
  randbase64=$(head -c 12 /dev/urandom | base64 | tr -d '\n')
  echo "  Base64: $randbase64"
fi

: # UUID generation:

echo "UUID generation:"
if command -v uuidgen >/dev/null 2>&1; then
  echo "  UUID: $(uuidgen)"
elif [ -f /proc/sys/kernel/random/uuid ]; then
  echo "  UUID: $(cat /proc/sys/kernel/random/uuid)"
else
  # Generate UUID v4 manually
  uuid=$(od -An -tx1 -N16 /dev/urandom | tr -d ' \n' \
    | sed 's/^\(.\{8\}\)\(.\{4\}\)\(.\{4\}\)\(.\{4\}\)\(.\{12\}\)$/\1-\2-4\3-\4-\5/' \
    | sed 's/^\(.\{19\}\)./\18/')
  echo "  UUID: $uuid"
fi

: # Random password generation:

generate_password() {
  length="${1:-16}"
  cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9!@#$%^&*' | head -c "$length"
  echo
}

echo "Random passwords:"
echo "  Simple: $(generate_password 12)"
echo "  Long: $(generate_password 24)"

: # [bash]
: # Random selection from array:
# fruits=("apple" "banana" "cherry" "date" "elderberry")
# random_index=$((RANDOM % ${#fruits[@]}))
# echo "Random fruit: ${fruits[$random_index]}"
: # [/bash]

: # POSIX random selection:

random_word() {
  words="$1"
  count=$(echo "$words" | wc -w)
  index=$(($(od -An -tu2 -N2 /dev/urandom | tr -d ' ') % count + 1))
  echo "$words" | cut -d' ' -f"$index"
}

echo "POSIX random selection:"
echo "  Random fruit: $(random_word "apple banana cherry date")"

: # Random boolean:

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

: # Weighted random selection:

weighted_random() {
  # Weights: apple=50%, banana=30%, cherry=20%
  roll=$(($(od -An -tu1 -N1 /dev/urandom | tr -d ' ') % 100))
  if [ "$roll" -lt 50 ]; then
    echo "apple"
  elif [ "$roll" -lt 80 ]; then
    echo "banana"
  else
    echo "cherry"
  fi
}

echo "Weighted random (5 trials):"
for _ in 1 2 3 4 5; do
  echo "  $(weighted_random)"
done

: # Dice roll simulation:

roll_die() {
  sides="${1:-6}"
  echo $(($(od -An -tu2 -N2 /dev/urandom | tr -d ' ') % sides + 1))
}

echo "Dice rolls:"
echo "  D6: $(roll_die 6)"
echo "  D20: $(roll_die 20)"
echo "  2D6: $(($(roll_die 6) + $(roll_die 6)))"

: # Coin flip:

coin_flip() {
  if [ $(($(od -An -tu1 -N1 /dev/urandom | tr -d ' ') % 2)) -eq 0 ]; then
    echo "heads"
  else
    echo "tails"
  fi
}

echo "Coin flips: $(coin_flip) $(coin_flip) $(coin_flip)"

echo "Random numbers examples complete"
