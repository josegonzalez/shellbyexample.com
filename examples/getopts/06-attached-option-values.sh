#!/bin/sh
# When an option takes an argument, you can attach the value
# directly to the flag without a space. Both `-n Alice` and
# `-nAlice` work identically.
#
# This is useful for compact command lines and is commonly
# seen in tools like `tar -xvf archive.tar`.

demo() {
    name=""
    OPTIND=1
    while getopts "n:" opt; do
        case "$opt" in
            n) name="$OPTARG" ;;
        esac
    done
    echo "Name: $name"
}

echo "With space: -n Alice"
demo -n Alice

echo ""
echo "Attached: -nAlice"
demo -nAlice

echo ""
echo "Attached: -nBob"
demo -nBob
