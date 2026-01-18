#!/bin/sh
# Command groups with `{}` run in current shell, which is useful
# when you want to run multiple commands in a single group.
#
# Variables defined in a command group are visible to the parent shell.

echo "Command group demo:"
{
    y="group_value"
    echo "  In group"
}
echo "  y is: $y"
