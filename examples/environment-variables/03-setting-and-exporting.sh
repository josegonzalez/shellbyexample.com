#!/bin/sh
# There are several ways to create and export variables.
# Each approach has slightly different behavior.
#
# - `VAR=value` creates a shell-only variable
# - `export VAR=value` creates and exports in one step
# - `export VAR` exports an existing shell variable
#
# The key test: can a child process see the variable?
# Only exported variables are inherited by children.

# Method 1: Shell-only variable
DB_NAME="mydb"
echo "Method 1 - shell variable:"
echo "  Parent: DB_NAME=$DB_NAME"
sh -c 'echo "  Child:  DB_NAME=${DB_NAME:-<not visible>}"'

# Method 2: Set and export in one step
echo ""
echo "Method 2 - export in one step:"
export DB_HOST="localhost"
echo "  Parent: DB_HOST=$DB_HOST"
sh -c 'echo "  Child:  DB_HOST=$DB_HOST"'

# Method 3: Set first, export later
echo ""
echo "Method 3 - export on a separate line:"
DB_PORT="5432"
export DB_PORT
echo "  Parent: DB_PORT=$DB_PORT"
sh -c 'echo "  Child:  DB_PORT=$DB_PORT"'
