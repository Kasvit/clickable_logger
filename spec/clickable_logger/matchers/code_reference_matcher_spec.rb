# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Matchers::CodeReferenceMatcher do
  let(:matcher) { described_class.new }
  let(:config) { ClickableLogger.configuration }

  describe "#match?" do
    it "matches a message containing a code reference with an absolute path" do
      msg = "↳ /app/models/user.rb:42"
      expect(matcher.match?(msg)).to be_truthy
    end

    it "matches a message containing a code reference with a relative path" do
      msg = "↳ ./app/models/user.rb:42"
      expect(matcher.match?(msg)).to be_truthy
    end

    it "does not match a message without a code reference" do
      msg = "This is a random log message."
      expect(matcher.match?(msg)).to be_falsey
    end
  end

  describe "#process" do
    it "replaces code references with clickable links for absolute paths" do
      msg = "↳ /app/models/user.rb:42"
      absolute_path = File.expand_path("/app/models/user.rb", Rails.root)
      allow(File).to receive(:exist?).with(absolute_path).and_return(true)

      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to include("#{config.editor}://file#{absolute_path}:42")
    end

    it "replaces code references with clickable links for relative paths" do
      msg = "↳ ./app/models/user.rb:42"
      absolute_path = File.expand_path("./app/models/user.rb", Rails.root)
      allow(File).to receive(:exist?).with(absolute_path).and_return(true)

      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to include("#{config.editor}://file#{absolute_path}:42")
    end

    it "returns the original message if the file does not exist" do
      msg = "↳ ./app/models/user.rb:42"
      absolute_path = File.expand_path("./app/models/user.rb", Rails.root)
      allow(File).to receive(:exist?).with(absolute_path).and_return(false)

      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to eq(msg)
    end

    it "skips processing if the message already contains a clickable link" do
      msg = "↳ #{config.editor}://file/app/models/user.rb:42"
      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to eq(msg)
    end
  end
end
