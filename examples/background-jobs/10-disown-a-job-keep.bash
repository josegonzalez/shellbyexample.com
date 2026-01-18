#!/bin/bash
# Disowned job will keep running after shell exits.
#
# For job control in interactive shells:
#
# - `ctrl+z` suspends foreground job
# - `jobs` lists jobs
# - `fg` brings job to foreground
# - `bg` resumes job in background
# - `fg %1` brings job 1 to foreground

sleep 100 &
disown $!
