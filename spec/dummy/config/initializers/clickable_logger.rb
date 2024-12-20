# frozen_string_literal: true

ClickableLogger.configure do |config|
  config.editor = "vscode"
  config.osc_8_hyperlinks_supported = false
end

clickable_logger = ActiveSupport::Logger.new($stdout)
clickable_logger.formatter = ClickableLogger::Formatter.new(ClickableLogger.configuration)
Rails.logger = ActiveSupport::TaggedLogging.new(clickable_logger)
