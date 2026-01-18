//go:build tools

package tools

// This file pins tool dependencies that would otherwise be removed by go mod tidy.
// See https://github.com/golang/go/wiki/Modules#how-can-i-track-tool-dependencies-for-a-module

import (
	_ "github.com/fsnotify/fsnotify"
)
