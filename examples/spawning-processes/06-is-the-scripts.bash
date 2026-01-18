#!/bin/bash
# `$$` returns the process ID of the original shell that started the script,
# while `$BASHPID` returns the process ID of the current shell.
#
# Only `$$` is available in all shells, while `$BASHPID` is only available in Bash.

echo "Script PID: $$"
echo "Script BASHPID: $BASHPID"

{
    echo "Command group PID: $$"
    echo "Command group BASHPID: $BASHPID"
}

(
    echo "Subshell PID: $$"
    echo "Subshell BASHPID: $BASHPID"
)
