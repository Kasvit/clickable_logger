# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Matcher do
  let(:matcher) { described_class.new }

  it "raises NotImplementedError for #match?" do
    expect { matcher.match?("some message", nil) }.to raise_error(NotImplementedError)
  end

  it "raises NotImplementedError for #process" do
    expect { matcher.process("some message", nil) }.to raise_error(NotImplementedError)
  end
end
