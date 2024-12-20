# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::VERSION do
  it "has a version number" do
    expect(ClickableLogger::VERSION).to eq("0.1.0")
  end
end
