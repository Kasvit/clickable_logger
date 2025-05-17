require "clickable_logger/version"
require "clickable_logger/railtie"
require "clickable_logger/matcher"
require "clickable_logger/matchers/view_matcher"
require "clickable_logger/formatter"

module ClickableLogger
  # this will be set by the railtie
  mattr_accessor :code_path # Rails.root/app/**/*.*

  mattr_accessor :matchers
  @@matchers = [
    Matchers::ViewMatcher.new
  ]

  # for the future
  def self.configure
    yield self
  end
end
