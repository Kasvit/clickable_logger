# frozen_string_literal: true

module ClickableLogger
  module Formatter
    OSC_LINK_PREFIX = "\e]8;;"

    def call(severity, timestamp, progname, msg)
      text = super(severity, timestamp, progname, msg)

      # Skip if already hyperlinked
      return text if text.include?(OSC_LINK_PREFIX)

      # Apply matchers
      ClickableLogger.matchers.reduce(text) do |curr, matcher|
        matcher.match?(curr) ? matcher.process(curr) : curr
      end
    end
  end
end
