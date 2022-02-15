# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.collapse("#{__dir__}/beyond_api/resources")
loader.ignore("#{__dir__}/ext")
loader.ignore("#{__dir__}/generators")
loader.setup

Dir["#{__dir__}/ext*.rb"].each { |file| require file }

module BeyondApi
  extend BeyondApi::Logger

  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new

    yield configuration
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :open_timeout, :timeout, :remove_response_links,
                  :remove_response_key_underscores, :object_struct_responses, :raise_error_requests,
                  :log_headers, :log_bodies, :log_level, :all_pagination_size

    def initialize
      @client_id = nil
      @client_secret = nil
      @open_timeout = 2
      @timeout = 5
      @remove_response_links = false
      @remove_response_key_underscores = false
      @object_struct_responses = false
      @raise_error_requests = false

      @log_level = :info
      @log_headers = false
      @log_bodies = false

      @all_pagination_size = 200
    end
  end
end

loader.eager_load
