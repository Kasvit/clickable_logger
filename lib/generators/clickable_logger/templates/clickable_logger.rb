# extend the logger formatter to add clickable links to the log messages

if defined?(ClickableLogger)
  Rails.logger.formatter.class.send(:prepend, ClickableLogger::Formatter)
end
