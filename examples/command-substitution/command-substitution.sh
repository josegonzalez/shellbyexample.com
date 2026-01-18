#!/bin/sh

: # Command substitution lets you capture the output
: # of a command and use it as a value. This is one
: # of the most powerful features in shell scripting.

: # The modern syntax uses `$(command)`.

current_date=$(date)
echo "Current date: $current_date"

: # You can also use backticks, but `$()` is preferred
: # because it's easier to nest and read.

current_user=`whoami`
echo "Current user: $current_user"

: # Command substitution is commonly used to store
: # command output in variables.

file_count=$(ls | wc -l)
echo "Files in current directory: $file_count"

: # You can use it directly in strings.

echo "You are logged in as $(whoami) on $(hostname)"

: # Command substitution can be nested with `$()` syntax.

echo "Today is $(date +%A), week $(date +%V)"

: # Capture the contents of a file.

echo "Config: $(cat /etc/hostname)"

: # Use it for conditional checks.

kernel=$(uname -s)
echo "Running on kernel: $kernel"

: # Command substitution strips trailing newlines from
: # the output. This is usually what you want.

output=$(echo "Hello")
echo "Output: '$output'"

: # Store command exit in a variable too if needed.

result=$(ls /nonexistent 2>&1)
exit_code=$?
echo "Exit code was: $exit_code"

: # You can use command substitution in arithmetic.

files=$(ls | wc -l)
echo "Double the files: $((files * 2))"
