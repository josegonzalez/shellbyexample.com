# Shell by Example

[Shell by Example](https://shellbyexample.com) is a hands-on introduction
to shell scripting using annotated example programs. Inspired by
[Go by Example](https://gobyexample.com).

## Building

To build the site you'll need Go installed. Then run:

```shell
make build
```

This will generate the static site in the `public` directory.

## Serving

To build and serve the site locally:

```shell
make serve
```

Then visit [http://localhost:8000](http://localhost:8000).

## Testing

```shell
make test
```

## Documentation

See the [docs/](docs/) folder for contributor documentation, including:

- [Writing Examples](docs/writing-examples.md)
- [Project Structure](docs/project-structure.md)

### License

This work is licensed under a [MIT License](LICENSE).

### Inspiration

This project was inspired by [Go by Example](https://gobyexample.com)
by Mark McGranaghan.
