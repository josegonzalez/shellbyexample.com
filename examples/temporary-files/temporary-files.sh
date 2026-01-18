#!/bin/sh

: # Temporary files are essential for shell scripts that
: # need to store intermediate data. The `mktemp` command
: # creates them safely.

: # Basic temporary file with mktemp:

tmpfile=$(mktemp)
echo "Created temp file: $tmpfile"
echo "Hello, temp!" >"$tmpfile"
cat "$tmpfile"
rm "$tmpfile"

: # mktemp creates unique files in $TMPDIR (or /tmp):

echo "TMPDIR: ${TMPDIR:-/tmp}"

: # Custom prefix with template:

tmpfile=$(mktemp /tmp/myapp.XXXXXX)
echo "Custom prefix: $tmpfile"
rm "$tmpfile"

: # At least 6 X's are required for the random suffix.

: # Create temporary directory:

tmpdir=$(mktemp -d)
echo "Created temp dir: $tmpdir"
touch "$tmpdir/file1.txt"
touch "$tmpdir/file2.txt"
ls "$tmpdir"
rm -rf "$tmpdir"

: # Custom directory template:

tmpdir=$(mktemp -d /tmp/myapp.XXXXXX)
echo "Custom temp dir: $tmpdir"
rm -rf "$tmpdir"

: # Always clean up temp files - use trap:

demo_trap_cleanup() {
  local tmpfile
  tmpfile=$(mktemp)
  trap 'rm -f "$tmpfile"' EXIT

  echo "Working with $tmpfile"
  echo "data" >"$tmpfile"
  # Even if script exits early, cleanup runs
}
demo_trap_cleanup

: # Multiple temp files with cleanup:

cleanup_files() {
  (
    tmpfile1=$(mktemp)
    tmpfile2=$(mktemp)
    tmpdir=$(mktemp -d)
    trap 'rm -f "$tmpfile1" "$tmpfile2"; rm -rf "$tmpdir"' EXIT

    echo "Files: $tmpfile1, $tmpfile2"
    echo "Dir: $tmpdir"
    # Work with temp files...
  )
}
echo "Cleanup demo:"
cleanup_files

: # Named pipe (FIFO) for inter-process communication:

tmpfifo=$(mktemp -u) # -u just prints name, doesn't create
mkfifo "$tmpfifo"
echo "Created FIFO: $tmpfifo"

# Producer (background)
echo "message" >"$tmpfifo" &

# Consumer
read -r msg <"$tmpfifo"
echo "Received: $msg"

rm "$tmpfifo"

: # [bash]
: # Using process substitution instead of temp files.
: # This avoids creating explicit temp files:
# diff <(sort file1.txt) <(sort file2.txt)
# while read -r line; do
#     echo "$line"
# done < <(some_command)
: # [/bash]

: # POSIX alternative using named pipes:

compare_sorted() {
  tmp1=$(mktemp)
  tmp2=$(mktemp)
  trap 'rm -f "$tmp1" "$tmp2"' EXIT

  printf "b\na\nc\n" | sort >"$tmp1"
  printf "c\na\nd\n" | sort >"$tmp2"
  echo "Diff of sorted inputs:"
  diff "$tmp1" "$tmp2" || true
}
compare_sorted

: # Secure temp file patterns:

: # Don't do this (predictable, race condition):
: # bad_tmpfile="/tmp/myapp.$$"  # PID is predictable

: # Do this instead:
safe_tmpfile=$(mktemp)
echo "Safe temp file: $safe_tmpfile"
rm "$safe_tmpfile"

: # Set restrictive permissions:

tmpfile=$(mktemp)
chmod 600 "$tmpfile" # Read/write for owner only
ls -la "$tmpfile"
rm "$tmpfile"

: # Temp file in specific directory:

# mktemp --tmpdir=/var/tmp myapp.XXXXXX  # GNU
# Or use template:
customtmp=$(mktemp /var/tmp/myapp.XXXXXX 2>/dev/null || mktemp)
echo "Custom location: $customtmp"
rm "$customtmp"

: # Check temp space before creating large files:

check_temp_space() {
  avail=$(df -P "${TMPDIR:-/tmp}" | awk 'NR==2 {print $4}')
  echo "Available space in temp: $avail KB"
}
check_temp_space

: # Atomic file operations with temp files:

atomic_write() {
  target="$1"
  content="$2"

  tmpfile=$(mktemp "$(dirname "$target")/tmp.XXXXXX")
  echo "$content" >"$tmpfile"
  mv "$tmpfile" "$target"
}

atomic_write /tmp/atomic_test.txt "Atomic content"
cat /tmp/atomic_test.txt
rm /tmp/atomic_test.txt

: # Collect output from multiple processes:

collect_output() {
  tmpdir=$(mktemp -d)
  trap 'rm -rf "$tmpdir"' EXIT

  # Simulate parallel tasks
  echo "result1" >"$tmpdir/task1"
  echo "result2" >"$tmpdir/task2"

  # Collect results
  echo "Collected results:"
  cat "$tmpdir"/*
}
collect_output

: # Here-document to temp file:

tmpfile=$(mktemp)
cat >"$tmpfile" <<'EOF'
Line 1
Line 2
Line 3
EOF
echo "From heredoc temp file:"
cat "$tmpfile"
rm "$tmpfile"

: # In-memory temp file using /dev/shm (Linux):

if [ -d /dev/shm ]; then
  ramtmp=$(mktemp /dev/shm/myapp.XXXXXX)
  echo "RAM-based temp: $ramtmp"
  rm "$ramtmp"
else
  echo "/dev/shm not available"
fi

: # Fallback if mktemp is unavailable:

portable_mktemp() {
  template="${1:-/tmp/tmp.XXXXXX}"
  dir=$(dirname "$template")
  prefix=$(basename "$template" | sed 's/X*$//')

  # Generate random suffix
  suffix=$(awk 'BEGIN{srand(); for(i=1;i<=6;i++) printf "%c", 65+int(rand()*26)}')

  result="$dir/${prefix}${suffix}"
  touch "$result"
  chmod 600 "$result"
  echo "$result"
}

echo "Portable mktemp: $(portable_mktemp)"
rm "$(portable_mktemp)"

echo "Temporary files examples complete"
