#!/bin/sh

: # Shell provides powerful string manipulation through
: # parameter expansion. These techniques work without
: # calling external commands.

: # String length with ${#var}:

str="Hello, World!"
echo "String: '$str'"
echo "Length: ${#str}"

: # [bash]
: # Substring extraction with ${var:start:length}:
: # Note: This is bash-specific, not POSIX sh
# text="Hello, World!"
# echo "First 5 chars: ${text:0:5}"
# echo "From position 7: ${text:7}"
# echo "Last 6 chars: ${text: -6}"  # Note the space before -
: # [/bash]

: # POSIX alternative for substrings uses expr or cut:

echo "POSIX substring with expr:"
text="Hello, World!"
echo "  First 5: $(expr "$text" : '\(.....\)')"
echo "  Using cut: $(echo "$text" | cut -c1-5)"

: # Remove prefix with ${var#pattern} and ${var##pattern}:

filepath="/home/user/documents/file.txt"
echo "Path: $filepath"

# Remove shortest match from beginning
echo "Remove leading /: ${filepath#/}"

# Remove longest match from beginning
echo "Remove path (##*/): ${filepath##*/}"

: # Remove suffix with ${var%pattern} and ${var%%pattern}:

# Remove shortest match from end
echo "Remove extension (%.*): ${filepath%.*}"

# Remove longest match from end
echo "Directory only (%%/*): ${filepath%%/*}"

: # More practical examples:

filename="document.backup.tar.gz"
echo "Filename: $filename"
echo "Remove .gz: ${filename%.gz}"
echo "Remove all extensions: ${filename%%.*}"
echo "Get extension: ${filename##*.}"

: # Extract directory and filename:

path="/usr/local/bin/script.sh"
echo "Path: $path"
echo "Directory: ${path%/*}"
echo "Filename: ${path##*/}"
echo "Basename without ext: $(basename "${path%.*}")"

: # [bash]
: # Substitution with ${var/pattern/replacement}:
# msg="hello world world"
# echo "Replace first: ${msg/world/universe}"
# echo "Replace all: ${msg//world/universe}"
# echo "Replace at start: ${msg/#hello/hi}"
# echo "Replace at end: ${msg/%world/planet}"
: # [/bash]

: # POSIX substitution alternatives:

msg="hello world world"
echo "POSIX substitution with sed:"
echo "  Replace first: $(echo "$msg" | sed 's/world/universe/')"
echo "  Replace all: $(echo "$msg" | sed 's/world/universe/g')"

: # [bash4]
: # Case conversion (bash 4+):
# word="Hello World"
# echo "Uppercase: ${word^^}"
# echo "Lowercase: ${word,,}"
# echo "First char upper: ${word^}"
# echo "First char lower: ${word,}"
: # [/bash4]

: # POSIX case conversion:

word="Hello World"
echo "POSIX case conversion with tr:"
echo "  Uppercase: $(echo "$word" | tr '[:lower:]' '[:upper:]')"
echo "  Lowercase: $(echo "$word" | tr '[:upper:]' '[:lower:]')"

: # String comparison:

s1="apple"
s2="banana"

if [ "$s1" = "$s2" ]; then
  echo "$s1 equals $s2"
else
  echo "$s1 does not equal $s2"
fi

# Lexicographic comparison
if [ "$s1" \< "$s2" ]; then
  echo "$s1 comes before $s2"
fi

: # Check if string is empty or not:

empty=""
nonempty="hello"

[ -z "$empty" ] && echo "empty is zero-length"
[ -n "$nonempty" ] && echo "nonempty has content"

: # Check if string contains substring:

haystack="The quick brown fox"
needle="quick"

case "$haystack" in
  *"$needle"*) echo "'$haystack' contains '$needle'" ;;
  *) echo "'$haystack' does not contain '$needle'" ;;
esac

: # [bash]
: # Using [[ ]] for pattern matching:
# if [[ "$haystack" == *quick* ]]; then
#     echo "Found quick"
# fi

: # Using =~ for regex:
# if [[ "$haystack" =~ ^The ]]; then
#     echo "Starts with 'The'"
# fi
: # [/bash]

: # Split string into parts:

csv="apple,banana,cherry"
echo "Splitting '$csv':"

# Using IFS
IFS=','
set -- $csv
echo "  Part 1: $1"
echo "  Part 2: $2"
echo "  Part 3: $3"
unset IFS

: # [bash]
: # Join array elements:
# fruits=("apple" "banana" "cherry")
# IFS=','
# echo "Joined: ${fruits[*]}"
# unset IFS
: # [/bash]

: # Trim whitespace:

padded="   hello world   "
echo "Padded: '$padded'"

# Using sed:
trimmed=$(echo "$padded" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
echo "Trimmed: '$trimmed'"

: # [bash]
: # Using parameter expansion (bash):
# trimmed="${padded#"${padded%%[![:space:]]*}"}"
# trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
: # [/bash]

: # Repeat a string:

repeat_char() {
  char="$1"
  count="$2"
  result=""
  i=0
  while [ "$i" -lt "$count" ]; do
    result="$result$char"
    i=$((i + 1))
  done
  echo "$result"
}

echo "Repeat '-' 20 times: $(repeat_char '-' 20)"

: # String formatting with printf:

printf "Padded: |%10s|\n" "hello"
printf "Left:   |%-10s|\n" "hello"

echo "String manipulation examples complete"
