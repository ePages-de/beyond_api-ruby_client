# frozen_string_literal: true

require 'active_support/all'
require 'faraday'
require 'faraday/retry'
require 'forwardable'
require 'json'
require 'zeitwerk'

module BeyondApi
  loader = Zeitwerk::Loader.for_gem
  loader.push_dir("#{__dir__}/beyond_api/services", namespace: BeyondApi)
  loader.ignore("#{__dir__}/generators")
  loader.setup

  extend Logger

  class << self
    attr_accessor :configuration

    def setup
      self.configuration ||= Configuration.new

      yield configuration
    end
  end
end
