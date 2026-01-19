//go:build ignore

package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

var runAll = flag.Bool("all", false, "renumber all example directories")

func main() {
	flag.Usage = func() {
		fmt.Fprintln(os.Stderr, "Usage: go run tools/renumber.go [options] <directory>")
		fmt.Fprintln(os.Stderr, "       go run tools/renumber.go --all")
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Options:")
		flag.PrintDefaults()
		fmt.Fprintln(os.Stderr, "")
		fmt.Fprintln(os.Stderr, "Examples:")
		fmt.Fprintln(os.Stderr, "  go run tools/renumber.go examples/hello-world")
		fmt.Fprintln(os.Stderr, "  go run tools/renumber.go --all")
	}
	flag.Parse()

	if *runAll {
		if err := renumberAll(); err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
		return
	}

	if flag.NArg() < 1 {
		flag.Usage()
		os.Exit(1)
	}

	dir := flag.Arg(0)
	if err := renumberFiles(dir); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}

func renumberAll() error {
	entries, err := os.ReadDir("examples")
	if err != nil {
		return fmt.Errorf("reading examples directory: %w", err)
	}

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}
		dir := filepath.Join("examples", entry.Name())
		fmt.Printf("Processing %s...\n", dir)
		if err := renumberFiles(dir); err != nil {
			return fmt.Errorf("%s: %w", dir, err)
		}
	}
	return nil
}

type numberedFile struct {
	number   int
	rest     string
	fullPath string
}

func renumberFiles(dir string) error {
	// Pattern to match numbered files: NN-description.ext
	pattern := regexp.MustCompile(`^(\d+)-(.+)$`)

	entries, err := os.ReadDir(dir)
	if err != nil {
		return fmt.Errorf("reading directory: %w", err)
	}

	// Collect all numbered files
	var files []numberedFile
	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}
		name := entry.Name()
		matches := pattern.FindStringSubmatch(name)
		if matches == nil {
			continue
		}
		num, _ := strconv.Atoi(matches[1])
		files = append(files, numberedFile{
			number:   num,
			rest:     matches[2],
			fullPath: filepath.Join(dir, name),
		})
	}

	// Sort by current number, then by filename
	sort.Slice(files, func(i, j int) bool {
		if files[i].number != files[j].number {
			return files[i].number < files[j].number
		}
		return files[i].rest < files[j].rest
	})

	// Group by original number AND base name to keep .sh and .output.txt together
	// but not merge different numbered examples with the same base name
	type fileGroup struct {
		number int
		base   string
		files  []numberedFile
	}

	var groups []*fileGroup
	groupMap := make(map[string]*fileGroup)

	for _, f := range files {
		// Extract base name (remove .output.txt or extension)
		base := f.rest
		base = strings.TrimSuffix(base, ".output.txt")
		base = strings.TrimSuffix(base, ".sh")
		base = strings.TrimSuffix(base, ".bash")

		// Key includes original number to keep different numbered examples separate
		key := fmt.Sprintf("%d-%s", f.number, base)

		if g, ok := groupMap[key]; ok {
			g.files = append(g.files, f)
		} else {
			g := &fileGroup{
				number: f.number,
				base:   base,
				files:  []numberedFile{f},
			}
			groupMap[key] = g
			groups = append(groups, g)
		}
	}

	// Groups are already in order since we processed sorted files

	// Determine renames needed
	type rename struct {
		from string
		to   string
	}
	var renames []rename

	newNum := 1
	for _, g := range groups {
		for _, f := range g.files {
			newName := fmt.Sprintf("%02d-%s", newNum, f.rest)
			newPath := filepath.Join(dir, newName)
			if f.fullPath != newPath {
				renames = append(renames, rename{from: f.fullPath, to: newPath})
			}
		}
		newNum++
	}

	if len(renames) == 0 {
		fmt.Println("Files are already numbered correctly.")
		return nil
	}

	// Print planned renames
	fmt.Println("Planned renames:")
	for _, r := range renames {
		fmt.Printf("  %s -> %s\n", filepath.Base(r.from), filepath.Base(r.to))
	}

	// Use temp names to avoid conflicts
	tempRenames := make([]rename, len(renames))
	for i, r := range renames {
		tempPath := r.from + ".renumber_temp"
		tempRenames[i] = rename{from: r.from, to: tempPath}
	}

	// First pass: rename to temp names
	for _, r := range tempRenames {
		if err := os.Rename(r.from, r.to); err != nil {
			return fmt.Errorf("renaming %s to temp: %w", r.from, err)
		}
	}

	// Second pass: rename from temp to final names
	for i, r := range renames {
		tempPath := tempRenames[i].to
		if err := os.Rename(tempPath, r.to); err != nil {
			return fmt.Errorf("renaming temp to %s: %w", r.to, err)
		}
	}

	fmt.Printf("\nRenamed %d files.\n", len(renames))
	return nil
}
