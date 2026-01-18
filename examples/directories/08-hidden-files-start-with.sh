#!/bin/sh
# Hidden files (start with `.`):

mkdir -p /tmp/testdir
touch /tmp/testdir/.hidden
echo "Including hidden files:"
ls -a /tmp/testdir
