#!/bin/sh

: # Shell provides several ways to write data to files
: # using redirection operators. This example covers
: # common file writing patterns.

: # Basic write with > (overwrites existing file):

echo "Hello, World!" >/tmp/output.txt
echo "Created file with: $(cat /tmp/output.txt)"

: # Append with >> (adds to end of file):

echo "First line" >/tmp/append.txt
echo "Second line" >>/tmp/append.txt
echo "Third line" >>/tmp/append.txt
echo "Appended file:"
cat /tmp/append.txt

: # Write multiple lines with here-document:

cat >/tmp/multiline.txt <<'EOF'
This is line 1
This is line 2
This is line 3
EOF
echo "Here-document file:"
cat /tmp/multiline.txt

: # Here-document with variable expansion:

name="Alice"
cat >/tmp/template.txt <<EOF
Hello, $name!
Today is $(date +%Y-%m-%d)
Your home is $HOME
EOF
echo "Template with variables:"
cat /tmp/template.txt

: # Write without newline using printf:

printf "No newline here" >/tmp/nonewline.txt
printf " - continued\n" >>/tmp/nonewline.txt
cat /tmp/nonewline.txt

: # Redirect stdout and stderr:

echo "Redirect stdout (1) and stderr (2):"

# Stdout only to file
ls /tmp >/tmp/stdout.txt 2>/dev/null

# Stderr only to file
ls /nonexistent 2>/tmp/stderr.txt

# Both to same file
ls /tmp /nonexistent >/tmp/both.txt 2>&1

# Both to different files
ls /tmp /nonexistent >/tmp/out.txt 2>/tmp/err.txt

echo "  Stderr captured: $(cat /tmp/stderr.txt)"

: # Discard output:

echo "Discarding output:"
ls /nonexistent 2>/dev/null # Discard stderr
echo "  Stderr discarded (no error shown)"

: # Tee - write to file and stdout simultaneously:

echo "Using tee:"
echo "This goes to both" | tee /tmp/tee.txt
echo "File contains: $(cat /tmp/tee.txt)"

echo "Append with tee -a:"
echo "Appended line" | tee -a /tmp/tee.txt >/dev/null
cat /tmp/tee.txt

: # Write from pipeline:

echo "Pipeline to file:"
seq 1 5 | grep -v 3 >/tmp/pipeline.txt
cat /tmp/pipeline.txt

: # Atomic write (write to temp, then rename):

atomic_write() {
  tmpfile=$(mktemp)
  echo "Important data" >"$tmpfile"
  mv "$tmpfile" "$1"
}

atomic_write /tmp/atomic.txt
echo "Atomic write result: $(cat /tmp/atomic.txt)"

: # Write with file descriptor:

exec 3>/tmp/fd.txt
echo "Line 1" >&3
echo "Line 2" >&3
exec 3>&- # Close the file descriptor
echo "File descriptor write:"
cat /tmp/fd.txt

: # Append with file descriptor:

exec 4>>/tmp/fd.txt
echo "Appended line" >&4
exec 4>&-
cat /tmp/fd.txt

: # Create file if not exists, don't overwrite:

if [ ! -f /tmp/nooverwrite.txt ]; then
  echo "New content" >/tmp/nooverwrite.txt
fi
echo "Safe write (no overwrite): $(cat /tmp/nooverwrite.txt)"

: # Truncate file to empty:

echo "content" >/tmp/truncate.txt
: >/tmp/truncate.txt # or > /tmp/truncate.txt
echo "After truncate, size: $(wc -c </tmp/truncate.txt) bytes"

: # [bash]
: # Bash provides noclobber option to prevent overwriting:

# set -o noclobber
# echo "test" > existingfile.txt  # Fails if file exists
# echo "test" >| existingfile.txt  # Force overwrite
# set +o noclobber
: # [/bash]

: # Write to multiple files at once:

echo "Multiple files" | tee /tmp/file1.txt /tmp/file2.txt >/dev/null
echo "File1: $(cat /tmp/file1.txt)"
echo "File2: $(cat /tmp/file2.txt)"

: # Write binary data:

printf '\x48\x65\x6c\x6c\x6f' >/tmp/binary.txt
echo "Binary write: $(cat /tmp/binary.txt)"

: # Write with specific permissions:

(
  umask 077
  echo "Secret" >/tmp/secret.txt
)
ls -l /tmp/secret.txt | awk '{print "Permissions:", $1}'

: # Process substitution for writing (bash):
: # diff <(echo "a") <(echo "b")

: # Write configuration file:

write_config() {
  cat >"$1" <<EOF
# Configuration file
# Generated on $(date)

host=localhost
port=8080
debug=false
EOF
}

write_config /tmp/app.conf
echo "Config file:"
cat /tmp/app.conf

: # Cleanup temporary files:

rm -f /tmp/output.txt /tmp/append.txt /tmp/multiline.txt
rm -f /tmp/template.txt /tmp/nonewline.txt /tmp/stdout.txt
rm -f /tmp/stderr.txt /tmp/both.txt /tmp/out.txt /tmp/err.txt
rm -f /tmp/tee.txt /tmp/pipeline.txt /tmp/atomic.txt
rm -f /tmp/fd.txt /tmp/nooverwrite.txt /tmp/truncate.txt
rm -f /tmp/file1.txt /tmp/file2.txt /tmp/binary.txt
rm -f /tmp/secret.txt /tmp/app.conf

echo "File writing examples complete"
