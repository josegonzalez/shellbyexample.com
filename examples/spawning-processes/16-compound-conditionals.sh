#!/bin/sh
# Compound conditionals:

echo "Compound:"
(true && true) && echo "  Both true"
(true || false) && echo "  At least one true"
