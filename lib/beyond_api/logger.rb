# frozen_string_literal: true

require "logger"

module BeyondApi
  module Logger
    def logger
      @@logger ||= defined?(Rails) ? ::Rails.logger : ::Logger.new($stdout)
    end

    def logger=(logger)
      @@logger = logger
    end
  end
end
