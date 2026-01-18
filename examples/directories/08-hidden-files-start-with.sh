#!/bin/sh
# Hidden files (start with .):

touch /tmp/testdir/.hidden
echo "Including hidden files:"
ls -a /tmp/testdir
