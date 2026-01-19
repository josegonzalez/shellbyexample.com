#!/bin/sh
# Use `"$@"` to loop over script arguments. Each argument
# is preserved as a separate item, even if it contains
# spaces. This pattern is essential for scripts that
# process multiple files or values passed by the user.
#
# The `set --` command replaces positional parameters,
# useful for testing argument handling within a script.
# In a real script, arguments come from the command line.
#
# Shorthand: `for arg; do` is equivalent to `for arg in "$@"; do`.
# When `in LIST` is omitted, the loop defaults to `"$@"`.

set -- "first arg" "second arg" "third arg"

echo "Looping over \"\$@\":"
for arg in "$@"; do
    echo "  arg: $arg"
done

echo ""
echo "Shorthand (omit 'in \"\$@\"'):"
for arg; do
    echo "  arg: $arg"
done
