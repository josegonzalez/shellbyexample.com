#!/bin/sh
# `nohup` can be used to keep a command running even after the shell exits.

nohup long_command >output.log 2>&1 &
