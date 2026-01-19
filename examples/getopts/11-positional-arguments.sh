#!/bin/sh
# After options, scripts often need positional arguments
# (like filenames). The `OPTIND` variable tracks where
# getopts stopped parsing.
#
# Use `shift $((OPTIND-1))` to remove processed options,
# leaving only positional arguments in `$@`.

demo() {
    verbose=false
    OPTIND=1
    while getopts "v" opt; do
        case "$opt" in
            v) verbose=true ;;
        esac
    done
    shift $((OPTIND - 1))
    echo "Verbose: $verbose"
    echo "Files: $@"
}

echo "With -v file1.txt file2.txt:"
demo -v "file1.txt" "file2.txt"

echo "With just file3.txt:"
demo "file3.txt"
