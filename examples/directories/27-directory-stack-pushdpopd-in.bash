#!/bin/bash
# Directory stack (pushd/popd in bash):

pushd /tmp > /dev/null
echo "Pushed to: $(pwd)"
pushd /var > /dev/null
echo "Pushed to: $(pwd)"
popd > /dev/null
echo "Popped to: $(pwd)"
popd > /dev/null
