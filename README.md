# Bookmarks ![CI](https://github.com/tristandunn/bookmarks/workflows/CI/badge.svg)

A bookmarking application built with Ruby on Rails.

## Development

Install the dependencies and setup the database.

```
bin/setup
```

To run the application processes.

```
bin/dev
```

If you're making changes, be sure to write and run the tests.

```
bundle exec rake ruby:test
bundle exec rake javascript:test
```

Before pushing changes, check the code.

```
bundle exec rake css:lint
bundle exec rake erb:lint
bundle exec rake ruby:lint
bundle exec rake javascript:lint
```

Or you can run the tests with coverage and lint with a single command.

```
bundle exec rake check
```

### Docker

Build the image with Docker.

```
docker build -t bookmarks .
```

Run the server using the image.

```
docker run --rm -p 3000:80 -e SECRET_KEY_BASE=$(bin/rails secret) --name bookmarks bookmarks
```

## License

Bookmarks uses the MIT license. See [LICENSE](LICENSE) for more details.
