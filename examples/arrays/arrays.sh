#!/bin/bash

: # Arrays in Bash let you store multiple values in
: # a single variable. Note: Arrays are a Bash feature
: # and are not available in POSIX sh.

: # Create an array with parentheses.

fruits=("apple" "banana" "cherry" "date")

: # Access elements using index (0-based).

echo "First fruit: ${fruits[0]}"
echo "Second fruit: ${fruits[1]}"

: # Get all elements with [@] or [*].

echo "All fruits: ${fruits[@]}"

: # Get the number of elements.

echo "Number of fruits: ${#fruits[@]}"

: # Add an element to the end.

fruits+=("elderberry")
echo "After adding: ${fruits[@]}"

: # Set a specific index.

fruits[1]="blueberry"
echo "After replacing: ${fruits[@]}"

: # Loop over array elements.

echo "Iterating over fruits:"
for fruit in "${fruits[@]}"; do
    echo "  - $fruit"
done

: # Loop with indices.

echo "With indices:"
for i in "${!fruits[@]}"; do
    echo "  [$i] = ${fruits[$i]}"
done

: # Array slicing: ${array[@]:start:length}

echo "First three: ${fruits[@]:0:3}"
echo "From index 2: ${fruits[@]:2}"

: # Get array indices.

echo "Indices: ${!fruits[@]}"

: # Check if array is empty.

empty_array=()
if [ ${#empty_array[@]} -eq 0 ]; then
    echo "Array is empty"
fi

: # Create array from command output.

files=($(ls *.sh 2>/dev/null))
echo "Shell files: ${files[@]}"

: # Delete an element (leaves a gap in indices).

unset 'fruits[2]'
echo "After unset [2]: ${fruits[@]}"
echo "Indices now: ${!fruits[@]}"

: # [bash4]
: # Bash 4+ provides associative arrays (hash maps)
: # using `declare -A`:

# declare -A user
# user[name]="Alice"
# user[email]="alice@example.com"
# user[age]="30"

# echo "Name: ${user[name]}"
# echo "Email: ${user[email]}"

: # Iterate over associative array keys:

# for key in "${!user[@]}"; do
#     echo "$key: ${user[$key]}"
# done

: # Check if a key exists:

# if [[ -v user[name] ]]; then
#     echo "name key exists"
# fi
: # [/bash4]

: # [bash4]
: # Bash 4+ provides `mapfile` (or `readarray`) to read
: # lines from a file or command into an array:

# mapfile -t lines < /etc/passwd

: # Read only first 5 lines:

# mapfile -t -n 5 lines < /etc/passwd

: # Read from a command using process substitution:

# mapfile -t users < <(cut -d: -f1 /etc/passwd | head -5)
# echo "Users: ${users[@]}"

: # Read with a specific delimiter:

# mapfile -t -d ':' fields <<< "a:b:c:d"
: # [/bash4]
