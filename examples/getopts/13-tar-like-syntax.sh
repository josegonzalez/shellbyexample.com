#!/bin/sh
# A practical tar-like example: `-xvf archive.tar`
# combines boolean flags (`-x`, `-v`) with an option
# that takes an attached value (`-f archive.tar`).
#
# This pattern is common in Unix tools where multiple
# short options can be combined, with the last one
# optionally taking an argument.

tar_demo() {
    extract=false
    verbose=false
    file=""
    OPTIND=1
    while getopts "xvf:" opt; do
        case "$opt" in
            x) extract=true ;;
            v) verbose=true ;;
            f) file="$OPTARG" ;;
        esac
    done
    echo "Extract: $extract, Verbose: $verbose, File: $file"
}

echo "tar-like: -xvf archive.tar"
tar_demo -xvf archive.tar

echo ""
echo "Separate flags: -x -v -f archive.tar"
tar_demo -x -v -f archive.tar
