# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Matchers::ViewMatcher do
  let(:matcher) { described_class.new }
  let(:config) { ClickableLogger.configuration }

  before do
    allow(config).to receive(:code_path).and_return([
                                                      "#{Rails.root}/app/views/home/index.html.erb",
                                                      "#{Rails.root}/app/views/layouts/application.html.erb"
                                                    ])
  end

  describe "#match?" do
    it "matches a message containing a rendering view" do
      msg = "Rendering home/index.html.erb within layouts/application"
      expect(matcher.match?(msg)).to be_truthy
    end

    it "matches a message containing a rendered view" do
      msg = "Rendered home/index.html.erb within layouts/application"
      expect(matcher.match?(msg)).to be_truthy
    end

    it "does not match a message without a rendering or rendered view" do
      msg = "This is a random log message."
      expect(matcher.match?(msg)).to be_falsey
    end
  end

  describe "#process" do
    it "replaces view paths with clickable links" do
      msg = "Rendering home/index.html.erb within layouts/application"
      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to include("#{config.editor}://file./app/views/home/index.html.erb")
    end

    it "returns the original message if the view file is not found" do
      msg = "Rendering missing_view.html.erb within layouts/application"
      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to eq(msg)
    end

    it "skips processing if the message already contains a clickable link" do
      msg = "Rendering #{config.editor}://file./app/views/home/index.html.erb within layouts/application"
      processed_msg = matcher.process(msg, config)
      expect(processed_msg).to eq(msg)
    end
  end
end
