#!/bin/sh

: # The `for` loop iterates over a list of items.
: # It's one of the most commonly used control
: # structures in shell scripting.

: # Basic for loop over a list of words:

for fruit in apple banana cherry; do
    echo "I like $fruit"
done

: # Loop over files in a directory using globbing:

echo "Shell scripts in current directory:"
for file in *.sh; do
    # Check if glob matched anything
    [ -e "$file" ] || continue
    echo "  - $file"
done

: # Loop over command output using command substitution:

echo "Users with login shells:"
for user in $(cat /etc/passwd | cut -d: -f1 | head -5); do
    echo "  - $user"
done

: # POSIX sh lacks range syntax for 'for', so use 'while' instead:

echo "Counting to 5:"
i=1
while [ $i -le 5 ]; do
    echo "  $i"
    i=$((i + 1))
done

: # [bash]
: # Bash provides a C-style for loop with cleaner
: # numeric iteration:

# for ((i=1; i<=5; i++)); do
#     echo "  $i"
# done

: # Bash also supports brace expansion for ranges:

# for n in {1..5}; do
#     echo "  $n"
# done

: # Step values work too: {1..10..2} gives 1,3,5,7,9
: # [/bash]

: # You can also use seq if available:

echo "Using seq:"
for n in $(seq 1 3); do
    echo "  Number: $n"
done

: # Loop over positional parameters:

set -- first second third
for arg in "$@"; do
    echo "Argument: $arg"
done

: # Loop over lines in a file (safer than for loop):

echo "Reading lines:"
while IFS= read -r line || [ -n "$line" ]; do
    echo "  Line: $line"
done << 'EOF'
First line
Second line
Third line
EOF

: # The loop variable persists after the loop ends.

for letter in a b c; do
    :  # do nothing
done
echo "Last letter was: $letter"
