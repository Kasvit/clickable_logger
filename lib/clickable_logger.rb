# frozen_string_literal: true

require "rails"
require "active_support/all"
require "clickable_logger/engine"
require "clickable_logger/configuration"
require_relative "clickable_logger/matcher" # Load the base Matcher class

# Dynamically load all matchers
Dir.glob(File.join(__dir__, "clickable_logger", "matchers", "*.rb")).sort.each do |file|
  require file
end
require "clickable_logger/formatter"
require "clickable_logger/railtie"

module ClickableLogger
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new.tap do |config|
        config.matchers = [
          ClickableLogger::Matchers::CodeReferenceMatcher.new,
          ClickableLogger::Matchers::ViewMatcher.new
        ]
      end
    end

    def configure
      yield(configuration)
    end
  end
end
