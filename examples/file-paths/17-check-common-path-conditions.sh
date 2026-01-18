#!/bin/sh
# Check common path conditions:

testpath="/tmp"
echo "Path checks for $testpath:"
[ -e "$testpath" ] && echo "  Exists"
[ -d "$testpath" ] && echo "  Is directory"
[ -f "$testpath" ] && echo "  Is regular file" || echo "  Not regular file"
[ -L "$testpath" ] && echo "  Is symlink" || echo "  Not symlink"
[ -r "$testpath" ] && echo "  Is readable"
[ -w "$testpath" ] && echo "  Is writable"
[ -x "$testpath" ] && echo "  Is executable"
