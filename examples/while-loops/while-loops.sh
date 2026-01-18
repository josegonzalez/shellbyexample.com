#!/bin/sh

: # The `while` loop executes commands as long as
: # a condition is true. It's essential for
: # condition-based iteration.

: # Basic while loop counting from 1 to 5:

i=1
while [ "$i" -le 5 ]; do
  echo "Count: $i"
  i=$((i + 1))
done

: # The condition is tested before each iteration.
: # If false initially, the loop body never runs.

: # Countdown example:

echo "Countdown:"
n=5
while [ "$n" -gt 0 ]; do
  echo "  $n"
  n=$((n - 1))
done
echo "  Liftoff!"

: # While loops are great for reading files line by line:

echo "Reading lines:"
while IFS= read -r line; do
  echo "  -> $line"
done <<'EOF'
First line
Second line
Third line
EOF

: # The `IFS=` prevents leading/trailing whitespace trimming.
: # The `-r` flag prevents backslash interpretation.

: # Infinite loop with break:

count=0
while true; do
  count=$((count + 1))
  echo "Iteration $count"
  if [ "$count" -ge 3 ]; then
    echo "Breaking out"
    break
  fi
done

: # The `continue` statement skips to the next iteration:

echo "Skipping even numbers:"
i=0
while [ "$i" -lt 10 ]; do
  i=$((i + 1))
  # Skip even numbers
  if [ $((i % 2)) -eq 0 ]; then
    continue
  fi
  echo "  Odd: $i"
done

: # Reading from a command's output:

echo "First 3 users:"
who | head -3 | while read -r user tty rest; do
  echo "  User: $user on $tty"
done

: # Note: Variables modified inside a piped while loop
: # won't persist outside due to subshell behavior.

: # Use process substitution or here-string to avoid subshells.
: # In POSIX sh, redirect from a temp file or use a different approach.

: # While loop with multiple conditions:

x=0
y=10
while [ "$x" -lt 5 ] && [ "$y" -gt 5 ]; do
  echo "x=$x, y=$y"
  x=$((x + 1))
  y=$((y - 1))
done

: # The `until` loop is the opposite of while -
: # it runs until the condition becomes true:

echo "Until loop:"
num=1
until [ "$num" -gt 3 ]; do
  echo "  num is $num"
  num=$((num + 1))
done

: # Menu-driven loop example:

echo "Simple menu loop:"
choice=""
attempt=0
while [ "$choice" != "q" ] && [ "$attempt" -lt 3 ]; do
  attempt=$((attempt + 1))
  choice="q" # Simulate user choosing quit
  echo "  Attempt $attempt: User chose '$choice'"
done

: # Processing arguments with while and shift:

set -- arg1 arg2 arg3
echo "Processing arguments:"
while [ $# -gt 0 ]; do
  echo "  Arg: $1"
  shift
done

: # While loop for retry logic:

max_retries=3
retry=0
success=false

while [ "$retry" -lt "$max_retries" ]; do
  retry=$((retry + 1))
  echo "Attempt $retry of $max_retries"

  # Simulate success on third try
  if [ "$retry" -eq 3 ]; then
    success=true
    break
  fi

  echo "  Failed, retrying..."
  sleep 1
done

if [ "$success" = true ]; then
  echo "Succeeded!"
else
  echo "All retries failed"
fi
