#!/bin/bash
# In Bash, you can also use external `getopt` (GNU)
# for long option support:

opts=$(getopt -o vn: --long verbose,name: -- "$@")
eval set -- "$opts"
while true; do
    case "$1" in
        -v|--verbose) verbose=true; shift ;;
        -n|--name) name="$2"; shift 2 ;;
        --) shift; break ;;
    esac
done
