# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.collapse("#{__dir__}/beyond_api/resources")
loader.ignore("#{__dir__}/ext")
loader.ignore("#{__dir__}/generators")
loader.setup

Dir["#{__dir__}/ext/*.rb"].each { |file| require file }

module BeyondApi
  extend BeyondApi::Logger

  class << self
    def configuration
      @configuration ||= ::BeyondApi::Configuration.new
    end

    def setup
      yield configuration
    end
  end
end

loader.eager_load
