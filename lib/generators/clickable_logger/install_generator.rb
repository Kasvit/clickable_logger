# frozen_string_literal: true

module ClickableLogger
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_initializer
        template "clickable_logger.rb", "config/initializers/clickable_logger.rb"
      end
    end
  end
end
