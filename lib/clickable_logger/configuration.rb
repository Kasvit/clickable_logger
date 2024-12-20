# frozen_string_literal: true

module ClickableLogger
  class Configuration
    attr_accessor :editor, :osc_8_hyperlinks_supported, :matchers, :code_path

    DEFAULT_EDITOR = "vscode"

    def initialize
      @editor = DEFAULT_EDITOR
      @osc_8_hyperlinks_supported = false
      @code_path = Dir["#{Rails.root}/app/**/*.*"]
      @matchers = []
    end
  end
end
