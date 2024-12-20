# frozen_string_literal: true

module ClickableLogger
  module Matchers
    class CodeReferenceMatcher < Matcher
      CODE_REF_REGEX = %r{↳\s+(/?\S+\.[^:\s]+):(\d+)|(\./\S+\.[^:\s]+):(\d+)}.freeze

      def match?(msg)
        msg =~ CODE_REF_REGEX
      end

      def process(msg, config)
        return msg if msg.include?("#{config.editor}://file") # Skip already processed messages

        if msg =~ CODE_REF_REGEX
          file_path = ::Regexp.last_match(1) || ::Regexp.last_match(3) # Match either absolute or relative paths
          line_number = ::Regexp.last_match(2) || ::Regexp.last_match(4)
          return msg if file_path.nil? || line_number.nil?

          full_path = File.expand_path(file_path, Rails.root)
          if File.exist?(full_path)
            # Generate hyperlink without the extra `.`
            url = "#{config.editor}://file#{full_path}:#{line_number}"
            msg = msg.gsub("#{file_path}:#{line_number}", url)
          end
        end

        msg
      end
    end
  end
end
