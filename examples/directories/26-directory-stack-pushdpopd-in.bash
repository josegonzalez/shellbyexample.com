#!/bin/bash
# Directory stack (pushd/popd) with error handling

pushd /tmp >/dev/null || exit 1
echo "Pushed to: $(pwd)"
pushd /var >/dev/null || exit 1
echo "Pushed to: $(pwd)"
popd >/dev/null || exit 1
echo "Popped to: $(pwd)"
popd >/dev/null || exit 1
