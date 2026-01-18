#!/bin/sh
# Cleanup temporary files:

rm -f /tmp/output.txt /tmp/append.txt /tmp/multiline.txt
rm -f /tmp/template.txt /tmp/nonewline.txt /tmp/stdout.txt
rm -f /tmp/stderr.txt /tmp/both.txt /tmp/out.txt /tmp/err.txt
rm -f /tmp/tee.txt /tmp/pipeline.txt /tmp/atomic.txt
rm -f /tmp/fd.txt /tmp/nooverwrite.txt /tmp/truncate.txt
rm -f /tmp/file1.txt /tmp/file2.txt /tmp/binary.txt
rm -f /tmp/secret.txt /tmp/app.conf

echo "File writing examples complete"
