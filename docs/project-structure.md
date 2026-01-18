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

| File                | Description                                  |
| ------------------- | -------------------------------------------- |
| `generate.go`       | Main site generator                          |
| `generate_test.go`  | Unit tests for the generator                 |
| `migrate.go`        | Migration tool for legacy → new format       |
| `run-in-docker.sh`  | Docker runner for sandboxed script execution |
| `watch.go`          | File watcher for development (auto-rebuild)  |

## Templates Directory

| File           | Description                              |
| -------------- | ---------------------------------------- |
| `example.tmpl` | HTML template for individual examples    |
| `index.tmpl`   | HTML template for the index page         |
| `site.css`     | Stylesheet for the site                  |
| `clipboard.js` | JavaScript for copy-to-clipboard feature |

## Makefile Targets

| Target                 | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `build`                | Generate the static site                       |
| `serve`                | Build and serve locally at localhost:8000      |
| `test`                 | Run Go tests                                   |
| `clean`                | Remove generated files                         |
| `docker-pull`          | Pull the bash:5.3 Docker image                 |
| `test-examples`        | Run all scripts in Docker to verify they work  |
| `validate-safety`      | Check scripts only write to /tmp               |
| `migrate`              | Run migration from legacy to new format        |
| `watch`                | Watch for changes and auto-rebuild             |
