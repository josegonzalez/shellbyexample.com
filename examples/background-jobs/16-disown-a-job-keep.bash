#!/bin/bash
# Disown a job (keep running after shell exits):

sleep 100 &
disown $!
Now the job won't be killed when shell exits
