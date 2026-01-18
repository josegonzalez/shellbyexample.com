#!/bin/sh
# Write with specific permissions:

(
  umask 077
  echo "Secret" >/tmp/secret.txt
)
# shellcheck disable=SC2012
ls -l /tmp/secret.txt | awk '{print "Permissions:", $1}'
