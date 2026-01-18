#!/bin/sh
# Move/rename directory with `mv`:

mkdir -p /tmp/testdir_copy
mkdir -p /tmp/testdir_renamed

mv /tmp/testdir_copy /tmp/testdir_renamed
echo "Renamed to testdir_renamed"
