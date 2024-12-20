# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Configuration do
  describe "#initialize" do
    let(:config) { described_class.new }

    it "initializes with the default editor" do
      expect(config.editor).to eq("vscode")
    end

    it "initializes with OSC 8 hyperlinks disabled by default" do
      expect(config.osc_8_hyperlinks_supported).to be_falsey
    end

    it "initializes with an empty matchers array" do
      expect(config.matchers).to eq([])
    end

    it "initializes with the default code path including all files in the app directory" do
      expected_path = "#{Rails.root}/app/views/home/index.html.erb" # Use an expected file from the app directory
      expect(config.code_path).to include(expected_path)
    end

    it "initializes with the default code path including all files in the app directory" do
      config.code_path.each do |path|
        expect(path).to start_with("#{Rails.root}/app")
      end
    end
  end
end
