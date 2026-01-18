#!/bin/sh

: # Shell provides several tools for manipulating file
: # paths. The key commands are dirname, basename, and
: # realpath (or readlink).

: # dirname extracts the directory portion:

path="/home/user/documents/report.txt"
echo "Path: $path"
echo "Directory: $(dirname "$path")"

: # Multiple dirname calls go up the tree:

echo "Parent: $(dirname "$(dirname "$path")")"

: # basename extracts the filename:

echo "Filename: $(basename "$path")"

: # basename can strip a suffix:

echo "Without .txt: $(basename "$path" .txt)"

: # Combine dirname and basename:

fullpath="/var/log/syslog"
dir=$(dirname "$fullpath")
name=$(basename "$fullpath")
echo "Dir: $dir, Name: $name"

: # Handle paths with spaces:

spacepath="/home/user/my documents/my file.txt"
echo "Path with spaces:"
echo "  Dir: $(dirname "$spacepath")"
echo "  Name: $(basename "$spacepath")"

: # Parameter expansion alternatives (faster, no subshell):

file="/path/to/document.tar.gz"
echo "Parameter expansion:"
echo "  Directory: ${file%/*}"           # Remove last /...
echo "  Filename: ${file##*/}"           # Remove through last /
echo "  Extension: ${file##*.}"          # Remove through last .
echo "  Without ext: ${file%.*}"         # Remove last .xxx
echo "  Base name: ${file##*/}"
echo "  Base without ext: $(basename "${file%.*}")"

: # Get absolute path with realpath (GNU) or readlink:

echo "Absolute paths:"
# realpath resolves symlinks
realpath . 2>/dev/null || readlink -f . 2>/dev/null || pwd

: # PWD gives current directory:

echo "Current directory: $PWD"

: # Canonical path (resolve symlinks):

if command -v realpath > /dev/null 2>&1; then
    echo "Canonical /usr/bin: $(realpath /usr/bin)"
elif command -v readlink > /dev/null 2>&1; then
    echo "Canonical /usr/bin: $(readlink -f /usr/bin 2>/dev/null || echo '/usr/bin')"
fi

: # Check if path is absolute:

is_absolute() {
    case "$1" in
        /*) return 0 ;;
        *)  return 1 ;;
    esac
}

is_absolute "/home/user" && echo "/home/user is absolute"
is_absolute "relative/path" || echo "relative/path is relative"

: # Join paths safely:

join_path() {
    # Remove trailing slash from first, leading from second
    printf '%s/%s\n' "${1%/}" "${2#/}"
}

echo "Joined: $(join_path "/home/user" "documents")"
echo "Joined: $(join_path "/home/user/" "/documents")"

: # Get file extension:

get_extension() {
    filename="$1"
    case "$filename" in
        *.*) echo "${filename##*.}" ;;
        *)   echo "" ;;
    esac
}

echo "Extension of file.txt: $(get_extension "file.txt")"
echo "Extension of archive.tar.gz: $(get_extension "archive.tar.gz")"
echo "Extension of noext: $(get_extension "noext")"

: # Change extension:

change_extension() {
    echo "${1%.*}.$2"
}

echo "Change ext: $(change_extension "file.txt" "md")"

: # Relative path from one location to another:
: # (GNU realpath or Python needed for portable solution)

# realpath --relative-to=/home/user /home/user/docs/file.txt

: # Path normalization (remove . and ..):

normalize_path() {
    # Use cd and pwd for normalization
    cd "$1" 2>/dev/null && pwd
}

# Example if directories exist:
echo "Normalized /tmp/.: $(normalize_path "/tmp/.")"

: # Check common path conditions:

testpath="/tmp"
echo "Path checks for $testpath:"
[ -e "$testpath" ] && echo "  Exists"
[ -d "$testpath" ] && echo "  Is directory"
[ -f "$testpath" ] && echo "  Is regular file" || echo "  Not regular file"
[ -L "$testpath" ] && echo "  Is symlink" || echo "  Not symlink"
[ -r "$testpath" ] && echo "  Is readable"
[ -w "$testpath" ] && echo "  Is writable"
[ -x "$testpath" ] && echo "  Is executable"

: # Script's own directory:

echo "Script location:"
echo "  \$0: $0"

# Get script directory (works for sourced scripts too)
script_dir() {
    # Try readlink first for symlinks
    if command -v readlink > /dev/null 2>&1; then
        dir=$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")")
    else
        dir=$(dirname "$0")
    fi
    # Make absolute
    cd "$dir" 2>/dev/null && pwd || echo "$dir"
}

: # Split path into components:

echo "Path components:"
path="/usr/local/bin/script"
echo "$path" | tr '/' '\n' | while read -r component; do
    [ -n "$component" ] && echo "  $component"
done

: # Find common prefix of paths:

common_prefix() {
    printf '%s\n%s\n' "$1" "$2" | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/'
}

echo "Common prefix:"
echo "  $(common_prefix "/home/user/docs" "/home/user/pics")"

: # Practical example - process files with path manipulation:

echo "Processing example:"
for file in /tmp/*.txt 2>/dev/null; do
    [ -e "$file" ] || continue
    dir=$(dirname "$file")
    name=$(basename "$file" .txt)
    echo "  Would create: $dir/${name}_backup.txt"
done

echo "File path examples complete"
