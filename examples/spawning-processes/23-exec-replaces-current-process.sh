#!/bin/sh
# exec replaces current process:

demo_exec() {
  (
    echo "Before exec"
    exec echo "This replaces the subshell"
    echo "This never runs"
  )
  echo "After subshell"
}
demo_exec
