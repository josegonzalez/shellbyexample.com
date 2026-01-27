#!/bin/sh
# There are two kinds of variables in the shell: shell
# variables and environment variables. Understanding the
# difference is essential.
#
# A shell variable exists only in the current shell. If
# you start a child process, it cannot see the variable.
#
# An environment variable is inherited by child processes.
# The `export` command promotes a shell variable into an
# environment variable, making it visible to any program
# the shell launches.

# A regular shell variable — only visible here
SECRET="I am local"
echo "Parent sees SECRET: $SECRET"

# A child shell cannot see it
echo "Child sees SECRET:"
sh -c 'echo "  ${SECRET:-<not visible>}"'

# Export promotes it to an environment variable
export SECRET
echo ""
echo "After export:"
echo "Parent sees SECRET: $SECRET"

# Now the child shell can see it
echo "Child sees SECRET:"
sh -c 'echo "  $SECRET"'
