#!/bin/sh
# Case statements can be used in functions:

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
