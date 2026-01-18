#!/bin/sh

: # Comments in shell scripts start with the `#` character.
: # Everything after `#` on a line is ignored by the shell.

echo "This line runs" # This comment is ignored

: # Comments are essential for documenting your scripts.
: # They help others (and future you) understand what
: # the code does.

: # You can use comments to:
: #
: # - Explain complex logic
: # - Document function purposes
: # - Leave TODO notes
: # - Temporarily disable code

: # Multi-line comments don't have special syntax.
: # You simply start each line with `#`.

: # Here's an example of documenting a section:

# ==========================================
# Configuration Section
# ==========================================

CONFIG_FILE="/etc/myapp.conf"
LOG_DIR="/var/log/myapp"

: # You can also use comments to disable code temporarily.
: # This is sometimes called "commenting out" code.

echo "This runs"
# echo "This doesn't run"
echo "This also runs"

: # Note: There's no block comment syntax in shell.
: # Some people use here-documents for multi-line
: # comments, but that's a hack - just use `#`.
