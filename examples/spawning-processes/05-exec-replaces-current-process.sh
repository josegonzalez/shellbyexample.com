#!/bin/sh
# `exec` replaces current process with the new command.
#
# If executed in a subshell, any remaining code in the subshell will not run.

demo_exec() {
  (
    echo "Before exec"
    exec echo "This replaces the subshell"
    echo "This never runs"
  )
  echo "After subshell"
}
demo_exec
