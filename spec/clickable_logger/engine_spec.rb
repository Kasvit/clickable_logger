# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Engine do
  it "isolates the ClickableLogger namespace" do
    expect(described_class.isolated?).to be true
  end
end
