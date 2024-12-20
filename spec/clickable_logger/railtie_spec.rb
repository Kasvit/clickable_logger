# frozen_string_literal: true

require "spec_helper"

RSpec.describe ClickableLogger::Railtie do
  it "subscribes to start_processing notifications" do
    expect(ActiveSupport::Notifications.notifier.listeners_for("start_processing.action_controller")).not_to be_empty
  end

  it "subscribes to process_action notifications" do
    expect(ActiveSupport::Notifications.notifier.listeners_for("process_action.action_controller")).not_to be_empty
  end

  it "logs processing information for start_processing" do
    payload = { controller: "HomeController", action: "index", format: :html }
    expect(Rails.logger).to receive(:<<).with("Processing by HomeController#index as HTML\n")
    ActiveSupport::Notifications.instrument("start_processing.action_controller", payload)
  end

  it "logs processing information for process_action" do
    payload = { status: 200, view_runtime: 30.5, db_runtime: 10.2 }
    expect(Rails.logger).to receive(:<<).with(/Completed 200 OK in .*ms \(Views: 30.5ms | ActiveRecord: 10.2ms\)/)
    ActiveSupport::Notifications.instrument("process_action.action_controller", payload)
  end
end
