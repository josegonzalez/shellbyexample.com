# Shell by Example

[Shell by Example](https://shellbyexample.com) is a hands-on introduction
to shell scripting using annotated example programs. Inspired by
[Go by Example](https://gobyexample.com).

### Building

To build the site you'll need Go installed. Then run:

    $ make build

This will generate the static site in the `public` directory.

### Serving

To build and serve the site locally:

    $ make serve

Then visit [http://localhost:8000](http://localhost:8000).

### Testing

    $ make test

### Project Structure

- `examples/` - Shell script source files with annotations
- `examples.txt` - Master list of examples (determines site order)
- `templates/` - HTML templates for site generation
- `tools/` - Go-based site generator
- `public/` - Generated static site output
- `docs/` - Contributor documentation

### License

This work is licensed under a [MIT License](LICENSE).

### Inspiration

This project was inspired by [Go by Example](https://gobyexample.com)
by Mark McGranaghan.
