#!/bin/sh
# Write with specific permissions:

(
  umask 077
  echo "Secret" >/tmp/secret.txt
)
ls -l /tmp/secret.txt | awk '{print "Permissions:", $1}'
