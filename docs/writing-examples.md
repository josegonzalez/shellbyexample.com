# Writing Examples for Shell by Example

This guide explains how to write shell examples for the Shell by Example project.

## Directory Structure

Each example lives in its own directory under `examples/`. The project supports two formats:

### New Format (Sub-Examples)

The new format uses numbered sub-example files, each demonstrating a related concept:

```text
examples/
├── hello-world/
│   ├── 01-hello-world.sh
│   ├── 01-hello-world.output.txt
│   ├── 02-echo-basics.sh
│   ├── 02-echo-basics.output.txt
│   └── 03-echo-no-newline.sh
└── arrays/
    ├── 01-creating-arrays.bash
    ├── 01-creating-arrays.output.txt
    └── 02-accessing-elements.bash
```

### Legacy Format

The legacy format uses a single file with alternating documentation and code segments:

```text
examples/
├── hello-world/
│   └── hello-world.sh
└── for-loops/
    └── for-loops.sh
```

Both formats are supported and can coexist during migration.

## Naming Conventions

### Sub-Example Files (New Format)

- **Prefix**: Two-digit number (`01`, `02`, etc.) for ordering
- **Description**: Kebab-case descriptive name
- **Extension**: `.sh` for POSIX-compliant, `.bash` for Bash-specific
- **Output file**: Same base name with `.output.txt` suffix

Examples:

- `01-hello-world.sh` - POSIX script
- `02-creating-arrays.bash` - Bash-specific script
- `01-hello-world.output.txt` - Output file

### Legacy Files

- Use **kebab-case** for example names (e.g., `hello-world`, `for-loops`)
- The directory name **must match** the script name
- Keep names concise but descriptive

## Sub-Example Script Format (New Format)

Each sub-example uses standard `#` comments for documentation at the top of the file:

```sh
#!/bin/sh
# Our first shell script is the classic "Hello World".
# This example demonstrates the basic structure of a
# shell script.
#
# You can run this script by saving it to a file,
# making it executable with chmod +x, and running it.

echo "Hello, World!"
```

The generator:

1. Extracts leading `#` comments as documentation
2. Displays documentation above the code block
3. Loads the corresponding `.output.txt` file if present

### Grouping Concepts

Group related concepts into a single sub-example file. For example:

- Echo basics + multiple lines + no newline flag = good grouping
- Each unrelated concept = separate file

## Legacy Script Format

### Shebang (First Line)

Every script must start with a shebang:

- `#!/bin/sh` - For POSIX-compliant examples (preferred when possible)
- `#!/bin/bash` - For Bash-specific features

### Comment Syntax

| Syntax | Purpose | Where It Appears |
| -------- | --------- | ------------------ |
| `: # text` | Documentation | Left column (explanation) |
| `# text` | Code comment | Right column (code block only) |
| `code # comment` | Inline comment | Right column with the code |

### Segment Pattern

Structure your example as alternating documentation and code segments:

```sh
#!/bin/sh

: # Documentation explaining the concept.
: # Can span multiple lines for longer
: # explanations.

executable_code_here

: # Next documentation section explaining
: # the following code.

more_code
```

## Registration

To include your example on the site, add its ID to `examples.txt`:

```shell
# Shell by Example - Topic List
# Each line is an example ID (directory name under examples/)

hello-world
comments
variables
your-new-example
```

- One example ID per line
- Lines starting with `#` are comments (ignored)
- Order in this file determines order on the site

## Safety Requirements

### Script Constraints

1. **All file operations use `/tmp`** - Scripts may ONLY create/modify/delete files in `/tmp`
2. **No network access** - Scripts should not make network requests
3. **No destructive operations** - No `rm -rf /`, no writes outside `/tmp`
4. **Scripts clean up after themselves** - Use `trap` for cleanup where appropriate

### Docker-Based Execution

All scripts are executed in a sandboxed `bash:5.3` Docker container:

- Container runs with `--read-only` root filesystem
- Only `/tmp` is mounted writable
- No network access (`--network none`)
- Resource limits enforced (memory, CPU, timeout)
- Container is removed after execution

## Generating Output Files

Use the provided Makefile targets to generate output files:

```bash
# Generate output for a single script
make generate-output SCRIPT=examples/hello-world/01-hello-world.sh

# Generate outputs for all sub-examples
make generate-all-outputs

# Watch for changes and regenerate outputs automatically
make watch-outputs
```

## Renumbering Files

If you need to fix file numbering (e.g., after deleting or inserting files):

```bash
# Renumber files in a single directory
make renumber DIR=examples/hello-world

# Renumber all example directories
make renumber-all
```

The renumber tool:
- Ensures files start at `01`
- Removes gaps in numbering
- Keeps `.sh`/`.bash` and `.output.txt` files paired

## Validation

Run validation to check your examples:

```bash
# Run all validations
make validate

# Check numbering only (starts at 01, no gaps, valid shebangs)
make validate-numbering

# Check scripts only write to /tmp (static analysis)
make validate-safety

# Test all scripts run successfully in Docker
make test-examples
```

## Best Practices

### Content Guidelines

1. **Start with the concept** - Begin with documentation explaining what the sub-example teaches
2. **Show basic usage first** - Introduce simple cases before advanced patterns
3. **Keep sub-examples focused** - One related group of concepts per file
4. **Build progressively** - Later sub-examples can build on earlier ones

### Bash-Specific Features

When using Bash-specific features:

- Use `.bash` extension for the file
- Use `#!/bin/bash` as the shebang
- Note the Bash requirement in your opening documentation

```bash
#!/bin/bash
# Arrays in Bash let you store multiple values in
# a single variable. Note: Arrays are a Bash feature
# and are not available in POSIX sh.

arr=(one two three)
echo "${arr[0]}"
```

### Code Quality

- **Use proper quoting** - Quote variables to prevent word splitting
- **Handle errors gracefully** - Consider edge cases
- **Keep examples runnable** - Scripts should execute without errors
- **Use meaningful variable names** - Self-documenting code is best

## Building & Testing

### Build the Site

Run the build tool to generate the site:

```sh
make build
```

### Verify Output

Check your example at `public/{example-id}.html` after building.

### Syntax Check

Verify your script has valid syntax:

```sh
# For POSIX sh scripts
sh -n examples/{example-id}/01-*.sh

# For Bash scripts
bash -n examples/{example-id}/01-*.bash
```

### Test Execution

Run your scripts in Docker:

```sh
make test-examples
```

## Checklist for New Examples

Before submitting a new example:

- [ ] Sub-example files follow naming convention (`NN-description.sh/bash`)
- [ ] Script has appropriate shebang (`#!/bin/sh` or `#!/bin/bash`)
- [ ] Documentation uses `#` comments at the top
- [ ] Scripts only write to `/tmp`
- [ ] Example is added to `examples.txt`
- [ ] Scripts pass syntax check
- [ ] Scripts run successfully in Docker (`make test-examples`)
- [ ] Output files generated (`make generate-output SCRIPT=...`)
- [ ] Validation passes (`make validate`)
- [ ] Site builds successfully (`make build`)
