# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger do
  describe ".configuration" do
    it "returns a Configuration instance" do
      expect(ClickableLogger.configuration).to be_a(ClickableLogger::Configuration)
    end

    it "initializes with default matchers" do
      matchers = ClickableLogger.configuration.matchers
      expect(matchers).to include(an_instance_of(ClickableLogger::Matchers::ViewMatcher))
      expect(matchers).to include(an_instance_of(ClickableLogger::Matchers::CodeReferenceMatcher))
    end
  end

  describe ".configure" do
    it "yields the configuration" do
      expect { |b| ClickableLogger.configure(&b) }.to yield_with_args(ClickableLogger.configuration)
    end

    it "allows configuration to be modified" do
      original_matchers = ClickableLogger.configuration.matchers.dup
      ClickableLogger.configure do |config|
        config.matchers = []
      end
      expect(ClickableLogger.configuration.matchers).to be_empty
      # Restore original configuration
      ClickableLogger.configure do |config|
        config.matchers = original_matchers
      end
    end
  end
end
