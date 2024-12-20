# frozen_string_literal: true

module ClickableLogger
  module Matchers
    class ViewMatcher < Matcher
      VIEW_REGEX = /(Rendering|Rendered)\s+(layout\s+)?(\S+\.[a-zA-Z0-9._]+)/.freeze

      def match?(msg)
        msg =~ VIEW_REGEX
      end

      def process(msg, config)
        return msg if msg.include?("#{config.editor}://file") # Skip already processed messages

        if msg =~ VIEW_REGEX
          file_path = ::Regexp.last_match(3)
          return msg if file_path.nil? # Guard against nil

          full_path = config.code_path.find { |f| f.end_with?(file_path) }
          if full_path
            url = "#{config.editor}://file#{full_path}"
            hyperlink = url.gsub(Rails.root.to_s, ".")
            msg = msg.gsub(file_path, hyperlink)
          end
        end

        msg
      end
    end
  end
end
