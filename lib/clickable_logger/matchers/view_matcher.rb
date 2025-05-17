# frozen_string_literal: true

module ClickableLogger
  module Matchers
    class ViewMatcher < Matcher
      VIEW_REGEX = /(?:Rendering|Rendered)\s+(?:layout\s+)?(?<file>\S+?\.[^\s]+)/.freeze

      def match?(msg)
        msg =~ VIEW_REGEX
      end

      def process(msg)
        msg.gsub(VIEW_REGEX) do |match|
          file = Regexp.last_match[:file]
          # all views are in <controller>/<action>.html.erb
          full_path = file.include?("/") ? ClickableLogger.code_path.find { |path| path.end_with?(file) } : nil
          full_path ? match.sub(file, full_path) : match
        end
      end
    end
  end
end
