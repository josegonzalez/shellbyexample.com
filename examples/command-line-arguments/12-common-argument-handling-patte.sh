#!/bin/sh
# This pattern combines everything into a complete argument
# parser. The while/case loop handles flags and options:
#
# - `-h|--help` shows usage and exits
# - `-v|--verbose` sets a flag variable
# - `--` signals end of options (remaining args are files)
# - `-*` catches unknown options (report error)
# - `*` breaks the loop to process positional arguments

handle_args() {
    verbose=""

    while [ $# -gt 0 ]; do
        case "$1" in
            -h | --help)
                echo "Usage: script [-v|--verbose] [--] files..."
                return 0
                ;;
            -v | --verbose)
                verbose=true
                shift
                ;;
            --)
                shift
                break
                ;;
            -*)
                echo "Unknown option: $1" >&2
                return 1
                ;;
            *)
                break
                ;;
        esac
    done

    [ "$verbose" = true ] && echo "Verbose mode enabled"
    echo "Files to process: $*"
}

handle_args -v -- file1.txt file2.txt
