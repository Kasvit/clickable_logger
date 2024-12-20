# ClickableLogger

ClickableLogger is a Rails gem that enhances log readability by transforming file references into clickable links for your editor.

## Features
- **Clickable Links**: File paths in logs are transformed into clickable links (e.g., `vscode://file/...`).
- **Preserves Default Logs**: Standard Rails logs like `Processing by ...` and `Completed ...` are retained.
- **Configurable**: Set your preferred editor, match patterns, and other options.

## Installation
Add to your `Gemfile`:
```ruby
gem 'clickable_logger'
```

Run `bundle install`

## Configuration
Create an initializer `config/initializers/clickable_logger.rb`:

```ruby
ClickableLogger.configure do |config|
  # Editor used for clickable links. Supported editors:
  # - "vscode" (Visual Studio Code)
  # - "idea" (JetBrains IDEs like IntelliJ, RubyMine, etc.)
  # - "subl" (Sublime Text)
  # Default: "vscode"
  config.editor = "vscode"

  # Enable or disable OSC 8 hyperlink support for enhanced clickable links.
  # When true, links are wrapped using OSC 8 escape sequences.
  # Default: false
  config.osc_8_hyperlinks_supported = false

  # List of matchers used to process log messages. You can add or remove matchers.
  # Default matchers handle:
  # - View rendering logs
  # - Code reference logs
  # Example:
  # config.matchers = [
  #   ClickableLogger::Matchers::ViewMatcher.new,
  #   ClickableLogger::Matchers::CodeReferenceMatcher.new
  # ]
  config.matchers = [
    ClickableLogger::Matchers::ViewMatcher.new,
    ClickableLogger::Matchers::CodeReferenceMatcher.new
  ]

  # Paths to search for files in logs. By default, all files under `app/` are included.
  # Example:
  # config.code_path = Dir["#{Rails.root}/app/**/*.*"]
  config.code_path = Dir["#{Rails.root}/app/**/*.*"]
end

Rails.logger = ActiveSupport::TaggedLogging.new(
  ActiveSupport::Logger.new($stdout).tap do |logger|
    logger.formatter = ClickableLogger::Formatter.new(ClickableLogger.configuration)
  end
)
```

## Supported Editors
- vscode
- idea
- subl

## Contributing
Contributions are welcome! Feel free to open issues or pull requests. 