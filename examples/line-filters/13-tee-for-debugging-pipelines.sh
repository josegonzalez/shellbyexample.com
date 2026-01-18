#!/bin/sh
# Use `tee` to debug pipelines:

echo "Debug with tee:"
printf "a\nb\nc\n" | tee /dev/stderr | tr '[:lower:]' '[:upper:]'
