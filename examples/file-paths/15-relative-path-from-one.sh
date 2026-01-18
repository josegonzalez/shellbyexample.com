#!/bin/sh
# Relative path from one location to another via GNU `realpath`

mkdir -p /tmp/user/docs
touch /tmp/user/docs/file.txt

realpath --relative-to=/tmp/user /tmp/user/docs/file.txt
