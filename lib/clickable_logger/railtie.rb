# frozen_string_literal: true

module ClickableLogger
  class Railtie < ::Rails::Railtie
    initializer "clickable_logger.configure_logger" do |app|
      ClickableLogger.code_path = Dir.glob("#{Rails.root}/app/**/*.*").map { |p| p.gsub("#{Rails.root}/", "") }
    end
  end
end
