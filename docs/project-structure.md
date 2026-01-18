# Project Structure

Overview of the Shell by Example repository layout.

## Directories

| Path         | Description                                |
| ------------ | ------------------------------------------ |
| `examples/`  | Shell script source files with annotations |
| `templates/` | HTML templates for site generation         |
| `tools/`     | Go-based site generator and utilities      |
| `public/`    | Generated static site output (gitignored)  |
| `docs/`      | Contributor documentation                  |

## Key Files

| File           | Description                                     |
| -------------- | ----------------------------------------------- |
| `examples.txt` | Master list of examples (determines site order) |
| `Makefile`     | Build commands                                  |

## Example Directory Structure

The project supports two example formats:

### New Format (Sub-Examples)

Each example is broken into numbered sub-example files:

```text
examples/
└── hello-world/
    ├── 01-hello-world.sh           # First sub-example
    ├── 01-hello-world.output.txt   # Output from running the script
    ├── 02-echo-basics.sh           # Second sub-example
    ├── 02-echo-basics.output.txt
    └── 03-echo-no-newline.sh
```

**Naming convention:**

- `NN-description.sh` - POSIX shell script (numbered for ordering)
- `NN-description.bash` - Bash-specific script
- `NN-description.output.txt` - Script output

### Legacy Format

Single file per example with embedded documentation:

```text
examples/
└── for-loops/
    └── for-loops.sh
```

## Tools Directory

| File                 | Description                                  |
| -------------------- | -------------------------------------------- |
| `Dockerfile`         | Docker image with curl, jq, bc, wget, openssl |
| `generate.go`        | Main site generator                          |
| `generate_test.go`   | Unit tests for the generator                 |
| `generate-output.go` | Generate output files for scripts            |
| `renumber.go`        | Renumber sub-example files in a directory    |
| `run-in-docker.sh`   | Docker runner for sandboxed script execution |
| `validate.go`        | Validate example numbering and structure     |
| `watch.go`           | File watcher for development (auto-rebuild)  |
| `watch-outputs.go`   | Watch scripts and regenerate outputs         |

## Templates Directory

| File           | Description                              |
| -------------- | ---------------------------------------- |
| `example.tmpl` | HTML template for individual examples    |
| `index.tmpl`   | HTML template for the index page         |
| `site.css`     | Stylesheet for the site                  |
| `clipboard.js` | JavaScript for copy-to-clipboard feature |

## Makefile Targets

### Core

| Target  | Description                              |
| ------- | ---------------------------------------- |
| `build` | Generate the static site                 |
| `serve` | Build and serve locally at localhost:8000 |
| `test`  | Run Go tests                             |
| `clean` | Remove generated files                   |

### Docker and Output Generation

| Target                 | Description                                   |
| ---------------------- | --------------------------------------------- |
| `docker-build`         | Build the shellbyexample Docker image         |
| `generate-output`      | Generate output for a single script           |
| `generate-all-outputs` | Generate outputs for all sub-example scripts  |
| `test-examples`        | Run all scripts in Docker to verify they work |

### Validation

| Target              | Description                                         |
| ------------------- | --------------------------------------------------- |
| `validate`          | Run all validations                                 |
| `validate-numbering`| Check files start at 01, no gaps, valid shebangs    |

### Renumbering

| Target         | Description                                  |
| -------------- | -------------------------------------------- |
| `renumber`     | Renumber files in one directory (DIR=path)  |
| `renumber-all` | Renumber all example directories and validate |

### Development

| Target          | Description                              |
| --------------- | ---------------------------------------- |
| `watch`         | Watch for changes and auto-rebuild       |
| `watch-outputs` | Watch scripts and regenerate outputs     |
