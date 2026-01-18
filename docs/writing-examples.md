# Writing Examples for Shell by Example

This guide explains how to write shell examples for the Shell by Example project.

## Directory Structure

Each example lives in its own directory under `examples/`:

```text
examples/
├── hello-world/
│   └── hello-world.sh
├── for-loops/
│   └── for-loops.sh
└── arrays/
    └── arrays.sh
```

### Naming Conventions

- Use **kebab-case** for example names (e.g., `hello-world`, `for-loops`, `command-substitution`)
- The directory name **must match** the script name
- Keep names concise but descriptive

## Script Structure

### 1. Shebang (First Line)

Every script must start with a shebang:

- `#!/bin/sh` - For POSIX-compliant examples (preferred when possible)
- `#!/bin/bash` - For Bash-specific features (arrays, advanced string manipulation, etc.)

### 2. Comment Syntax

Shell by Example uses a special comment syntax to separate documentation from code:

| Syntax | Purpose | Where It Appears |
| -------- | --------- | ------------------ |
| `: # text` | Documentation | Left column (explanation) |
| `# text` | Code comment | Right column (code block only) |
| `code # comment` | Inline comment | Right column with the code |

### 3. Segment Pattern

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

**Key points:**

- Start with documentation explaining what the example demonstrates
- Leave a blank line between documentation and code
- Leave a blank line between code and the next documentation section
- Each `: #` line becomes part of the left-column explanation

### Example

Here's a properly structured example:

```sh
#!/bin/sh

: # Our first shell script is the classic "Hello World".
: # This example demonstrates the basic structure of a
: # shell script.

echo "Hello, World!"

: # The `echo` command prints text to standard output.
: # It's one of the most commonly used commands in
: # shell scripting.

echo "Welcome to Shell by Example!"
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

## Best Practices

### Content Guidelines

1. **Start with the concept** - Begin with documentation explaining what the example teaches
2. **Show basic usage first** - Introduce simple cases before advanced patterns
3. **Build progressively** - Each segment should build on previous ones
4. **Keep segments focused** - One concept per documentation/code pair

### Bash-Specific Features

When using Bash-specific features:

- Use `#!/bin/bash` as the shebang
- Note the Bash requirement in your opening documentation

```sh
#!/bin/bash

: # Arrays in Bash let you store multiple values in
: # a single variable. Note: Arrays are a Bash feature
: # and are not available in POSIX sh.
```

### Inline Bash Sections

For POSIX examples that want to show Bash alternatives, use inline bash markers.
These create visually distinct sections with an orange highlight.

**Supported markers:**

- `[bash]` - Generic bash (displays "Bash" label)
- `[bash4]` - Bash 4+ specific (displays "Bash 4+" label)
- `[bash5]` - Bash 5+ specific (displays "Bash 5+" label)
- `[bash 4+]` or `[bash 5+]` - Alternative syntax with space
- `[/bash]` - Ends bash section

**Example usage:**

```sh
#!/bin/sh

: # POSIX approach to read a file line by line:

while read -r line; do
    echo "$line"
done < file.txt

: # [bash4] With Bash 4+, use mapfile for better performance:

mapfile -t lines < file.txt
for line in "${lines[@]}"; do
    echo "$line"
done

: # [/bash]

: # Back to POSIX content here.
```

The bash section will be highlighted with an orange border and background,
making it clear to readers which parts require Bash.

### Code Quality

- **Use proper quoting** - Quote variables to prevent word splitting
- **Handle errors gracefully** - Consider edge cases
- **Keep examples runnable** - Scripts should execute without errors
- **Use meaningful variable names** - Self-documenting code is best

### Inline Comments vs Documentation

Use regular `#` comments for code-level details that belong with the code:

```sh
: # You can use comments to organize code sections.

# ==========================================
# Configuration Section
# ==========================================

CONFIG_FILE="/etc/myapp.conf"
LOG_DIR="/var/log/myapp"
```

Use inline comments sparingly for clarification:

```sh
echo "This line runs" # This comment is ignored
```

## Building & Testing

### Build the Site

Run the build tool to generate the site:

```sh
./tools/build
```

### Verify Output

Check your example at `public/{example-id}.html` after building.

### Syntax Check

Verify your script has valid syntax:

```sh
# For POSIX sh scripts
sh -n examples/{example-id}/{example-id}.sh

# For Bash scripts
bash -n examples/{example-id}/{example-id}.sh
```

### Test Execution

Run your script to ensure it works:

```sh
./examples/{example-id}/{example-id}.sh
```

## Checklist for New Examples

Before submitting a new example:

- [ ] Directory name matches script name (kebab-case)
- [ ] Script has appropriate shebang (`#!/bin/sh` or `#!/bin/bash`)
- [ ] Documentation uses `: #` syntax
- [ ] Blank lines separate documentation from code segments
- [ ] Example is added to `examples.txt`
- [ ] Script passes syntax check (`sh -n` or `bash -n`)
- [ ] Script executes without errors
- [ ] Site builds successfully with `./tools/build`
