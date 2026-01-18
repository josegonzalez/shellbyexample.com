#!/bin/sh

: # Variables in shell scripts store values that can
: # be referenced later. Unlike many programming languages,
: # shell variables don't require type declarations.

: # To assign a variable, use `NAME=value` with no spaces
: # around the `=` sign. This is important!

greeting="Hello"
name="World"

: # To use a variable's value, prefix it with `$`.

echo "$greeting, $name!"

: # You can also use curly braces for clarity,
: # especially when the variable name could be ambiguous.

file="report"
echo "${file}_2024.txt"

: # Without braces, this would try to find a variable
: # named `file_2024` which doesn't exist.

: # Variables can hold numbers too (as strings).

count=42
echo "The count is $count"

: # You can reassign variables at any time.

status="pending"
echo "Status: $status"
status="complete"
echo "Status: $status"

: # Variable names can contain letters, numbers, and
: # underscores. They cannot start with a number.

my_var="valid"
myVar2="also valid"
# 2invalid="would cause an error"

: # Unset variables expand to empty strings by default.

echo "Unset variable: '$undefined_var'"

: # Use `unset` to remove a variable.

temp="temporary"
echo "Before unset: $temp"
unset temp
echo "After unset: $temp"

: # [bash]
: # Bash provides powerful string manipulation within
: # parameter expansion:

: # String length with ${#var}:

# message="Hello, World!"
# echo "Length: ${#message}"  # 13

: # Substring extraction with ${var:start:length}:

# echo "${message:0:5}"   # Hello
# echo "${message:7}"     # World!

: # Remove prefix with ${var#pattern} (shortest) or
: # ${var##pattern} (longest):

# path="/home/user/docs/file.txt"
# echo "${path##*/}"      # file.txt (basename)

: # Remove suffix with ${var%pattern} (shortest) or
: # ${var%%pattern} (longest):

# echo "${path%/*}"       # /home/user/docs (dirname)
# filename="archive.tar.gz"
# echo "${filename%%.*}"  # archive

: # Search and replace with ${var/find/replace} (first)
: # or ${var//find/replace} (all):

# text="hello hello hello"
# echo "${text/hello/hi}"   # hi hello hello
# echo "${text//hello/hi}"  # hi hi hi
: # [/bash]
