# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Formatter do
  let(:config) { ClickableLogger.configuration }
  let(:formatter) { described_class.new(config) }

  describe "#initialize" do
    it "uses the provided configuration" do
      custom_config = double("CustomConfig")
      formatter = described_class.new(custom_config)
      expect(formatter.instance_variable_get(:@config)).to eq(custom_config)
    end

    it "falls back to default configuration if none is provided" do
      formatter = described_class.new
      expect(formatter.instance_variable_get(:@config)).to eq(ClickableLogger.configuration)
    end
  end

  describe "#call" do
    let(:timestamp) { Time.now }
    let(:severity) { "INFO" }

    context "when the message is nil" do
      it "returns an empty string" do
        expect(formatter.call(severity, timestamp, nil, nil)).to eq("")
      end
    end

    context "when the message contains 'Processing by'" do
      it "formats the message with severity and timestamp" do
        msg = "Processing by HomeController#index as HTML"
        result = formatter.call(severity, timestamp, nil, msg)
        expect(result).to eq("#{severity} [#{timestamp}] #{msg.strip}\n")
      end
    end

    context "when the message contains 'Completed'" do
      it "formats the message with severity and timestamp" do
        msg = "Completed 200 OK in 123.4ms (Views: 56.7ms | ActiveRecord: 12.3ms)"
        result = formatter.call(severity, timestamp, nil, msg)
        expect(result).to eq("#{severity} [#{timestamp}] #{msg.strip}\n")
      end
    end

    context "when the message is already processed" do
      it "returns the original message" do
        msg = "Rendering layout vscode://file./app/views/layouts/application.html.erb"
        result = formatter.call(severity, timestamp, nil, msg)
        expect(result).to eq(msg)
      end
    end

    context "when the message is unprocessed and matches a custom matcher" do
      before do
        allow(config.matchers.first).to receive(:match?).and_return(true)
        allow(config.matchers.first).to receive(:process).and_return("[PROCESSED] Custom log")
      end

      it "applies the matchers to process the message" do
        msg = "↳ app/models/user.rb:42:in `some_method`"
        result = formatter.call(severity, timestamp, nil, msg)
        expect(result).to eq("[PROCESSED] Custom log\n")
      end
    end

    context "when the message is unprocessed and does not match any matcher" do
      it "returns the original message with a newline" do
        msg = "This is a random log message."
        result = formatter.call(severity, timestamp, nil, msg)
        expect(result).to eq("#{msg}\n")
      end
    end
  end
end
