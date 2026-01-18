#!/bin/sh

: # Shell provides several commands for working with
: # directories: mkdir, rmdir, ls, find, and more.

: # Create a directory with mkdir:

mkdir /tmp/mydir
echo "Created /tmp/mydir"
ls -la /tmp/mydir

: # Create nested directories with -p:

mkdir -p /tmp/parent/child/grandchild
echo "Created nested directories:"
ls -la /tmp/parent/child/

: # -p also doesn't error if directory exists:

mkdir -p /tmp/mydir # No error

: # Remove empty directory with rmdir:

rmdir /tmp/mydir
echo "Removed /tmp/mydir"

: # Remove nested empty directories:

rmdir -p /tmp/parent/child/grandchild 2>/dev/null || true
echo "Removed nested directories"

: # List directory contents with ls:

mkdir -p /tmp/testdir
touch /tmp/testdir/file1.txt /tmp/testdir/file2.sh

echo "List directory:"
ls /tmp/testdir

echo "Detailed listing:"
ls -la /tmp/testdir

echo "One file per line:"
ls -1 /tmp/testdir

: # Hidden files (start with .):

touch /tmp/testdir/.hidden
echo "Including hidden files:"
ls -a /tmp/testdir

: # Check if directory exists:

if [ -d "/tmp/testdir" ]; then
  echo "/tmp/testdir exists"
fi

: # Change directory with cd:

original_dir=$(pwd)
cd /tmp/testdir
echo "Changed to: $(pwd)"
cd "$original_dir"
echo "Back to: $(pwd)"

: # Use subshell to avoid changing current directory:

(
  cd /tmp/testdir
  echo "In subshell: $(pwd)"
)
echo "Still in: $(pwd)"

: # Find files in directory with find:

mkdir -p /tmp/findtest/sub
touch /tmp/findtest/a.txt /tmp/findtest/b.sh /tmp/findtest/sub/c.txt

echo "Find all files:"
find /tmp/findtest -type f

echo "Find only .txt files:"
find /tmp/findtest -name "*.txt"

echo "Find by type (directories):"
find /tmp/findtest -type d

: # Find with depth limit:

echo "Max depth 1:"
find /tmp/findtest -maxdepth 1 -type f

: # Find with exec:

echo "Find and show sizes:"
find /tmp/findtest -type f -exec ls -la {} \;

: # Find files by age:

touch -d "2 days ago" /tmp/findtest/old.txt 2>/dev/null || touch /tmp/findtest/old.txt
echo "Files modified in last day:"
find /tmp/findtest -mtime -1 -type f

: # Directory size with du:

echo "Directory sizes:"
du -sh /tmp/testdir
du -sh /tmp/findtest

: # List subdirectory sizes:

echo "Subdirectory sizes:"
du -h /tmp/findtest

: # Count files in directory:

echo "File count: $(find /tmp/findtest -type f | wc -l)"

: # Iterate over directory contents:

echo "Loop over files:"
for file in /tmp/testdir/*; do
  [ -e "$file" ] || continue
  echo "  Found: $(basename "$file")"
done

: # Safe handling of special characters:

mkdir -p "/tmp/spaces dir"
touch "/tmp/spaces dir/file with spaces.txt"
echo "Files with spaces:"
for file in "/tmp/spaces dir"/*; do
  echo "  $file"
done
rm -rf "/tmp/spaces dir"

: # Copy directory with cp -r:

cp -r /tmp/testdir /tmp/testdir_copy
echo "Copied directory:"
ls /tmp/testdir_copy

: # Move/rename directory:

mv /tmp/testdir_copy /tmp/testdir_renamed
echo "Renamed to testdir_renamed"

: # Remove directory and contents with rm -r:

rm -rf /tmp/testdir_renamed
echo "Removed testdir_renamed"

: # Temporary directory:

tmpdir=$(mktemp -d)
echo "Created temp dir: $tmpdir"
rmdir "$tmpdir"

: # Get home directory:

echo "Home directory: $HOME"
echo "Tilde expansion: ~"

: # Special directories:

echo "Current: $PWD"
echo "Previous: ${OLDPWD:-not set}"

: # [bash]
: # Directory stack (pushd/popd in bash):
# pushd /tmp > /dev/null
# echo "Pushed to: $(pwd)"
# pushd /var > /dev/null
# echo "Pushed to: $(pwd)"
# popd > /dev/null
# echo "Popped to: $(pwd)"
# popd > /dev/null
: # [/bash]

: # Check for empty directory:

is_empty_dir() {
  [ -d "$1" ] && [ -z "$(ls -A "$1")" ]
}

mkdir /tmp/emptydir
if is_empty_dir /tmp/emptydir; then
  echo "/tmp/emptydir is empty"
fi
rmdir /tmp/emptydir

: # Create directory only if it doesn't exist:

ensure_dir() {
  [ -d "$1" ] || mkdir -p "$1"
}

ensure_dir /tmp/ensured
echo "Ensured /tmp/ensured exists"

: # Cleanup test directories

rm -rf /tmp/testdir /tmp/findtest /tmp/ensured

echo "Directory examples complete"
