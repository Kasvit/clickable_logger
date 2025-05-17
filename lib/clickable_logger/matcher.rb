# frozen_string_literal: true

module ClickableLogger
  class Matcher
    def match?(_msg)
      false
    end

    def process(msg, _config)
      msg
    end
  end
end
