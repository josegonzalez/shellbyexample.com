#!/bin/bash
# Disown a job (keep running after shell exits):
# Now the job won't be killed when shell exits

sleep 100 &
disown $!
