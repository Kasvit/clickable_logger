# frozen_string_literal: true

module ClickableLogger
  class Railtie < ::Rails::Railtie
    initializer "clickable_logger.action_controller" do
      ActiveSupport::Notifications.subscribe "start_processing.action_controller" do |_name, _start, _finish, _id, payload|
        Rails.logger << "Processing by #{payload[:controller]}##{payload[:action]} as #{payload[:format].to_s.upcase}\n"
      end

      ActiveSupport::Notifications.subscribe "process_action.action_controller" do |_name, start, finish, _id, payload|
        status = payload[:status] || 500
        runtime = (finish - start) * 1000
        view_runtime = payload[:view_runtime] || 0
        db_runtime = payload[:db_runtime] || 0
        Rails.logger << "Completed #{status} #{Rack::Utils::HTTP_STATUS_CODES[status]} in #{runtime.round(1)}ms " \
                        "(Views: #{view_runtime.round(1)}ms | ActiveRecord: #{db_runtime.round(1)}ms)\n"
      end
    end
  end
end
