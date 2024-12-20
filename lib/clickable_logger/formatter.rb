# frozen_string_literal: true

module ClickableLogger
  class Formatter < ::Logger::Formatter
    def initialize(config = nil)
      @config = config || ClickableLogger.configuration
    end

    def call(severity, timestamp, _progname, msg)
      return "" if msg.nil?

      original_msg = msg.to_s

      # Process logs related to "Processing by" and "Completed"
      return "#{severity} [#{timestamp}] #{original_msg.strip}\n" if original_msg.match?(/Processing by|Completed/)

      # Skip already processed messages
      return original_msg if original_msg.include?("#{@config.editor}://file")

      # Apply custom matchers
      processed_msg = @config.matchers.reduce(original_msg) do |current_msg, matcher|
        matcher.match?(current_msg) ? matcher.process(current_msg, @config) : current_msg
      end

      # Return processed or original message
      "#{processed_msg}\n"
    end
  end
end
