#!/bin/sh

: # Functions let you group commands together and
: # reuse them throughout your script. They're
: # essential for organizing larger scripts.

: # Define a function using the `name() { }` syntax.
: # The `function` keyword is optional and not POSIX.

greet() {
    echo "Hello, World!"
}

: # [bash]
: # Bash supports an alternative syntax using the
: # `function` keyword:

# function greet {
#     echo "Hello, World!"
# }

: # You can also combine both syntaxes:

# function greet() {
#     echo "Hello, World!"
# }
# another_greet_fn() {
#     echo "Hello, World!"
# }
: # [/bash]

: # Call a function by using its name.

greet

: # Functions can accept arguments via $1, $2, etc.

greet_user() {
    echo "Hello, $1!"
}

greet_user "Alice"
greet_user "Bob"

: # $@ contains all arguments, $# is the count.

show_args() {
    echo "Number of arguments: $#"
    for arg in "$@"; do
        echo "  - $arg"
    done
}

show_args one two three

: # Functions return exit status with `return`.
: # Return 0 for success, non-zero for failure.

is_even() {
    if [ $(($1 % 2)) -eq 0 ]; then
        return 0 # success/true
    else
        return 1 # failure/false
    fi
}

if is_even 4; then
    echo "4 is even"
fi

if ! is_even 7; then
    echo "7 is odd"
fi

: # To return string values, use command substitution.

get_greeting() {
    echo "Hello, $1!"
}

message=$(get_greeting "World")
echo "Got: $message"

: # Variables in functions are global by default.
: # Be careful with naming to avoid conflicts.

counter=0

increment() {
    counter=$((counter + 1))
}

increment
increment
echo "Counter: $counter"

: # [bash]
: # Bash provides the `local` keyword for function-scoped
: # variables that don't affect the global namespace:

# calculate() {
#     local result=0
#     local i
#     for i in "$@"; do
#         result=$((result + i))
#     done
#     echo "$result"
# }

# result="global"
# sum=$(calculate 1 2 3 4 5)
# echo "Sum: $sum"          # Sum: 15
# echo "Result: $result"    # Result: global (unchanged)
: # [/bash]

: # Functions must be defined before they're called.
: # Define all functions at the top of your script.
