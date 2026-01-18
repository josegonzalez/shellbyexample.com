#!/bin/sh

: # The `case` statement provides multi-way branching,
: # similar to switch statements in other languages.
: # It matches a value against patterns.

: # Basic case statement with simple patterns:

fruit="apple"

case "$fruit" in
  apple)
    echo "It's an apple"
    ;;
  banana)
    echo "It's a banana"
    ;;
  cherry)
    echo "It's a cherry"
    ;;
esac

: # The `;;` terminates each case block.
: # The `)` follows each pattern.

: # Use `*` as a default/catch-all pattern:

color="purple"

case "$color" in
  red)
    echo "Color is red"
    ;;
  blue)
    echo "Color is blue"
    ;;
  *)
    echo "Unknown color: $color"
    ;;
esac

: # Multiple patterns can match the same block using `|`:

day="Saturday"

case "$day" in
  Monday | Tuesday | Wednesday | Thursday | Friday)
    echo "$day is a weekday"
    ;;
  Saturday | Sunday)
    echo "$day is a weekend day"
    ;;
  *)
    echo "Invalid day"
    ;;
esac

: # Patterns support glob-style wildcards:

filename="script.sh"

case "$filename" in
  *.sh)
    echo "Shell script"
    ;;
  *.py)
    echo "Python script"
    ;;
  *.txt)
    echo "Text file"
    ;;
  *)
    echo "Unknown file type"
    ;;
esac

: # Case is often used for command-line option handling:

action="start"

case "$action" in
  start)
    echo "Starting service..."
    ;;
  stop)
    echo "Stopping service..."
    ;;
  restart)
    echo "Restarting service..."
    ;;
  status)
    echo "Checking status..."
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    ;;
esac

: # Character class patterns work too:

char="5"

case "$char" in
  [0-9])
    echo "'$char' is a digit"
    ;;
  [a-z])
    echo "'$char' is a lowercase letter"
    ;;
  [A-Z])
    echo "'$char' is an uppercase letter"
    ;;
  *)
    echo "'$char' is something else"
    ;;
esac

: # Case statements can be used in functions:

get_file_type() {
  case "$1" in
    *.tar.gz | *.tgz) echo "gzipped tarball" ;;
    *.tar.bz2 | *.tbz) echo "bzipped tarball" ;;
    *.tar) echo "tarball" ;;
    *.zip) echo "zip archive" ;;
    *.gz) echo "gzip compressed" ;;
    *) echo "unknown" ;;
  esac
}

echo "archive.tar.gz is a $(get_file_type archive.tar.gz)"
echo "data.zip is a $(get_file_type data.zip)"

: # [bash]
: # Bash adds `;;&` to fall through to test next pattern
: # and `;&` to fall through unconditionally:

# grade="B"
# case "$grade" in
#     A) echo "Excellent" ;;&
#     A|B) echo "Good" ;;&
#     A|B|C) echo "Passed" ;;
#     *) echo "Failed" ;;
# esac
: # [/bash]

: # Empty patterns are allowed (do nothing):

value="skip"

case "$value" in
  skip)
    # Do nothing
    ;;
  process)
    echo "Processing..."
    ;;
esac

echo "Done"
