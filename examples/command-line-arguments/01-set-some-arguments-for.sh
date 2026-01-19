#!/bin/sh
# Command-line arguments make scripts flexible and reusable.
# Instead of editing a script to change a filename or value,
# you can pass different values when running it:
#
#   ./backup.sh /home/user /backups
#   ./backup.sh /var/log /backups
#
# The same script works with different inputs. For these
# examples, we use `set --` to simulate arguments as if
# the script were called with: ./script hello world foo bar

set -- hello world foo bar
echo "Arguments set to: $@"
