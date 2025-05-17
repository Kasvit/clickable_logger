# frozen_string_literal: true

require "test_helper"

class ClickableLoggerTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert ClickableLogger::VERSION
  end

  test "view matcher" do
    assert_equal "Rendering app/views/users/index.html.erb", ClickableLogger::Matchers::ViewMatcher.new.process("Rendering users/index.html.erb")
    assert_equal "Rendering app/views/users/_user.html.erb", ClickableLogger::Matchers::ViewMatcher.new.process("Rendering users/_user.html.erb")
    assert_equal "Rendering aaaa", ClickableLogger::Matchers::ViewMatcher.new.process("Rendering aaaa")
    assert_equal "Rendering index.html.erb", ClickableLogger::Matchers::ViewMatcher.new.process("Rendering index.html.erb")
    assert_equal "Rendering app/views/users/index.html.erb", ClickableLogger::Matchers::ViewMatcher.new.process("Rendering app/views/users/index.html.erb")
    assert_equal "Hello World", ClickableLogger::Matchers::ViewMatcher.new.process("Hello World")
  end
end
