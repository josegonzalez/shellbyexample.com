#!/bin/sh

: # The `if` statement lets you execute code conditionally.
: # It's fundamental to controlling program flow in shell
: # scripts.

: # Basic if statement syntax:

if true; then
    echo "This always runs"
fi

: # The `if` tests the exit status of a command.
: # Exit status 0 means success (true), non-zero means
: # failure (false).

if ls /tmp > /dev/null 2>&1; then
    echo "/tmp exists and is readable"
fi

: # Use the `test` command or `[ ]` for comparisons.
: # Note: spaces inside `[ ]` are required!

value=10

if [ "$value" -eq 10 ]; then
    echo "Value is 10"
fi

: # String comparisons use `=` and `!=`.

name="Alice"

if [ "$name" = "Alice" ]; then
    echo "Hello, Alice!"
fi

: # Check if a string is empty or non-empty.

empty=""
nonempty="hello"

if [ -z "$empty" ]; then
    echo "Variable is empty"
fi

if [ -n "$nonempty" ]; then
    echo "Variable is not empty"
fi

: # Numeric comparisons:
: # -eq (equal), -ne (not equal)
: # -lt (less than), -le (less or equal)
: # -gt (greater than), -ge (greater or equal)

count=5

if [ "$count" -gt 3 ]; then
    echo "Count is greater than 3"
fi

: # File tests check file properties.

if [ -f "/etc/passwd" ]; then
    echo "/etc/passwd exists and is a file"
fi

if [ -d "/tmp" ]; then
    echo "/tmp exists and is a directory"
fi

: # Always quote variables in tests to handle empty
: # values and spaces correctly.

user_input=""
if [ "$user_input" = "" ]; then
    echo "No input provided"
fi

: # [bash]
: # Bash provides extended test syntax [[ ]] which is
: # safer and more powerful than single brackets.

: # With [[ ]], quoting is often optional:

# if [[ $name = Alice ]]; then
#     echo "Hello, Alice!"
# fi

: # Pattern matching with [[ ]]:

# if [[ $filename = *.txt ]]; then
#     echo "It's a text file"
# fi

: # Regex matching with =~:

# if [[ $email =~ ^[a-z]+@[a-z]+\.[a-z]+$ ]]; then
#     echo "Valid email format"
# fi

: # Bash also provides (( )) for arithmetic evaluation,
: # which is cleaner for numeric comparisons:

# if (( count > 3 )); then
#     echo "Count is greater than 3"
# fi

# if (( x >= 0 && x <= 100 )); then
#     echo "x is between 0 and 100"
# fi
: # [/bash]
