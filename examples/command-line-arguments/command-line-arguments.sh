#!/bin/sh

: # Shell scripts can access command-line arguments
: # through special variables. This example demonstrates
: # how to work with positional parameters.

: # Set some arguments for demonstration:

set -- hello world foo bar

: # $0 is the script name (or shell name in interactive mode):

echo "Script name: $0"

: # $1, $2, etc. are positional parameters:

echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"

: # $# is the number of arguments:

echo "Number of arguments: $#"

: # $@ expands to all arguments as separate words:

echo "All arguments (\$@):"
for arg in "$@"; do
  echo "  - $arg"
done

: # $* expands to all arguments as a single word when quoted:

echo "All arguments (\$*):"
echo "  $*"

: # The difference matters with spaces in arguments:

set -- "hello world" "foo bar"
echo "With quoted \$@:"
for arg in "$@"; do
  echo "  [$arg]"
done

echo "With quoted \$*:"
for arg in "$*"; do
  echo "  [$arg]"
done

: # Always use "$@" (quoted) to preserve argument boundaries.

: # `shift` removes the first argument and shifts others down:

set -- first second third fourth
echo "Before shift: $1 $2 $3 $4"
shift
echo "After shift: $1 $2 $3"
shift 2
echo "After shift 2: $1"

: # Common pattern: Process all arguments with shift:

set -- -v --name=test file1.txt file2.txt

echo "Processing arguments with shift:"
while [ $# -gt 0 ]; do
  echo "  Processing: $1"
  shift
done

: # Check if arguments were provided:

check_args() {
  if [ $# -eq 0 ]; then
    echo "No arguments provided"
    return 1
  fi
  echo "Got $# argument(s)"
}

check_args
check_args one two

: # Default values for missing arguments:

set -- customvalue

name="${1:-default_name}"
port="${2:-8080}"
echo "Name: $name, Port: $port"

: # ${var:-default} uses default if var is unset or empty
: # ${var:=default} also assigns the default to var

: # Require an argument (exit if missing):

require_arg() {
  : "${1:?Error: First argument required}"
  echo "Got required arg: $1"
}

require_arg "provided"
# require_arg  # Would cause an error

: # Arguments beyond $9 need braces:

set -- a b c d e f g h i j k l

echo "Arg 1: $1"
echo "Arg 9: $9"
echo "Arg 10: ${10}"
echo "Arg 12: ${12}"

: # Check for specific number of arguments:

exactly_two() {
  if [ $# -ne 2 ]; then
    echo "Usage: exactly_two <arg1> <arg2>"
    return 1
  fi
  echo "Got exactly two: $1 and $2"
}

exactly_two one two
exactly_two one

: # Parse arguments into variables:

set -- source.txt destination.txt --verbose

src="$1"
dst="$2"
verbose=""

for arg in "$@"; do
  case "$arg" in
    --verbose | -v) verbose=true ;;
  esac
done

echo "Source: $src"
echo "Destination: $dst"
echo "Verbose: ${verbose:-false}"

: # $$ is the script's process ID:

echo "Script PID: $$"

: # $! is the PID of the last background command:

sleep 1 &
echo "Background PID: $!"
wait

: # [bash]
: # Bash provides additional variables:
: #
: # - `$BASHPID` - PID of current bash process (differs in subshells)
: # - `${@:n:m}` - Slice of arguments starting at n, m elements
: # - `${!#}`    - The last argument

# echo "Last argument: ${!#}"
# echo "Args 2-3: ${@:2:2}"
: # [/bash]

: # Common argument handling pattern:

handle_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h | --help)
        echo "Usage: script [options] files..."
        return 0
        ;;
      -v | --verbose)
        echo "Verbose mode on"
        shift
        ;;
      --)
        shift
        break # Rest are positional args
        ;;
      -*)
        echo "Unknown option: $1" >&2
        return 1
        ;;
      *)
        break # Start of positional args
        ;;
    esac
  done

  echo "Remaining arguments: $*"
}

handle_args -v -- file1 file2
