# frozen_string_literal: true

module ClickableLogger
  class Matcher
    def match?(msg, config)
      raise NotImplementedError
    end

    def process(msg, config)
      raise NotImplementedError
    end
  end
end
