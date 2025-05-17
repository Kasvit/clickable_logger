# frozen_string_literal: true

Rails.logger.formatter.class.send(:prepend, ClickableLogger::Formatter)
