#!/bin/sh
# Use `<<-EOF` to strip leading tabs (not spaces).
# This helps with indentation in scripts.

cat <<-EOF
	This line had a leading tab.
	So did this one.
	The tabs are stripped from output.
	EOF
