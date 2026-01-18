#!/bin/sh
# Practical example: Format currency using `printf`.

format_currency() {
  printf "$%.2f\n" "$1"
}
format_currency 1234.56
format_currency 99.99
