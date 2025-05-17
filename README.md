# ClickableLogger

Increase your productivity in 30 seconds.

ClickableLogger is a Rails logger formatter that makes it easy to navigate to the code from the logs.

And now you can click "Cmd+Click" on the log message to open the file in your editor.

## Before & After

Before:

![Before](./docs/before.png)

After:

![After](./docs/after.png)

## Usage

30 seconds to get started:

1. Install the gem
2. Generate the initializer
3. Start the server


## Installation
Add this line to your application's Gemfile:

```ruby
gem "clickable_logger", group: :development
```

And then execute:
```bash
$ bundle
```

## Configuration

```bash
rails g clickable_logger:install
```

This will create a `config/initializers/clickable_logger.rb` file.

## Testing

Run tests with:
```bash
bin/test
```

## Contributing

You are welcome to contribute to the project.

Some ideas:

- more matchers
- more tests

## License
The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
