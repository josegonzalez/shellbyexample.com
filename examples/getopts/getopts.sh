#!/bin/sh

: # `getopts` is a built-in command for parsing
: # command-line options. It handles short options
: # like `-v`, `-n value`, and combined flags `-vn`.

: # Basic getopts usage:

demo_basic() {
  # Reset OPTIND for each demo function
  OPTIND=1

  verbose=false
  name=""

  while getopts "vn:" opt; do
    case "$opt" in
      v) verbose=true ;;
      n) name="$OPTARG" ;;
      ?)
        echo "Usage: cmd [-v] [-n name]"
        return 1
        ;;
    esac
  done

  echo "Verbose: $verbose"
  echo "Name: ${name:-<not set>}"
}

echo "Basic getopts demo:"
set -- -v -n "Alice"
demo_basic "$@"

: # The optstring "vn:" means:
: # v - flag (no argument)
: # n: - option with required argument (colon after)

: # OPTARG contains the argument for options with `:`.
: # OPTIND is the index of the next argument to process.

: # Handle multiple combined flags:

demo_combined() {
  OPTIND=1
  a=false b=false c=false

  while getopts "abc" opt; do
    case "$opt" in
      a) a=true ;;
      b) b=true ;;
      c) c=true ;;
    esac
  done

  echo "a=$a b=$b c=$c"
}

echo "Combined flags (-abc):"
set -- -abc
demo_combined "$@"

: # Access remaining arguments after options:

demo_remaining() {
  OPTIND=1
  verbose=false

  while getopts "v" opt; do
    case "$opt" in
      v) verbose=true ;;
    esac
  done

  # Shift past the processed options
  shift $((OPTIND - 1))

  echo "Verbose: $verbose"
  echo "Remaining args: $*"
}

echo "Remaining arguments:"
set -- -v file1.txt file2.txt
demo_remaining "$@"

: # Silent error mode (leading colon):

demo_silent() {
  OPTIND=1

  # Leading : suppresses error messages
  while getopts ":vn:" opt; do
    case "$opt" in
      v) echo "Got -v" ;;
      n) echo "Got -n with value: $OPTARG" ;;
      :) echo "Option -$OPTARG requires an argument" ;;
      \?) echo "Unknown option: -$OPTARG" ;;
    esac
  done
}

echo "Silent mode (handles errors ourselves):"
set -- -v -n -x
demo_silent "$@"

: # Practical example: A script with multiple options

process_files() {
  OPTIND=1
  verbose=false
  output=""
  format="text"

  while getopts "vo:f:" opt; do
    case "$opt" in
      v) verbose=true ;;
      o) output="$OPTARG" ;;
      f) format="$OPTARG" ;;
      \?)
        echo "Usage: process [-v] [-o output] [-f format] files..."
        return 1
        ;;
    esac
  done
  shift $((OPTIND - 1))

  echo "Settings:"
  echo "  Verbose: $verbose"
  echo "  Output: ${output:-<stdout>}"
  echo "  Format: $format"
  echo "  Files: ${*:-<none>}"
}

echo "Complete example:"
set -- -v -o result.txt -f json input1.txt input2.txt
process_files "$@"

: # getopts only handles short options.
: # For long options (--verbose), parse manually:

demo_long_opts() {
  verbose=false
  name=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -v | --verbose)
        verbose=true
        shift
        ;;
      -n | --name)
        name="$2"
        shift 2
        ;;
      --name=*)
        name="${1#--name=}"
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "Unknown option: $1"
        return 1
        ;;
      *)
        break
        ;;
    esac
  done

  echo "Verbose: $verbose"
  echo "Name: ${name:-<not set>}"
  echo "Remaining: $*"
}

echo "Long options (manual parsing):"
demo_long_opts --verbose --name=Bob file.txt

: # [bash]
: # In Bash, you can also use external `getopt` (GNU)
: # for long option support:

# opts=$(getopt -o vn: --long verbose,name: -- "$@")
# eval set -- "$opts"
# while true; do
#     case "$1" in
#         -v|--verbose) verbose=true; shift ;;
#         -n|--name) name="$2"; shift 2 ;;
#         --) shift; break ;;
#     esac
# done
: # [/bash]

: # Default values with getopts:

demo_defaults() {
  OPTIND=1
  host="${HOST:-localhost}"
  port="${PORT:-8080}"

  while getopts "h:p:" opt; do
    case "$opt" in
      h) host="$OPTARG" ;;
      p) port="$OPTARG" ;;
    esac
  done

  echo "Host: $host, Port: $port"
}

echo "With defaults:"
demo_defaults
set -- -p 3000
demo_defaults "$@"

: # Help option pattern:

show_help() {
  cat <<'EOF'
Usage: script [options] [files...]

Options:
  -h        Show this help
  -v        Verbose output
  -o FILE   Output file
  -n NAME   Set name
EOF
}

demo_help() {
  OPTIND=1

  while getopts "hvo:n:" opt; do
    case "$opt" in
      h)
        show_help
        return 0
        ;;
      v) echo "Verbose mode" ;;
      o) echo "Output: $OPTARG" ;;
      n) echo "Name: $OPTARG" ;;
      \?)
        show_help
        return 1
        ;;
    esac
  done
}

echo "Help option:"
set -- -h
demo_help "$@"
