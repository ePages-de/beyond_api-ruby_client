require "beyond_api/version"

require "beyond_api/connection"
require "beyond_api/request"
require "beyond_api/session"

require "beyond_api/ext"
require "beyond_api/utils"

module BeyondAPI
  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new

    yield configuration
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :open_timeout, :timeout, :object_struct_responses

    def initialize
      @client_id = nil
      @client_secret = nil
      @open_timeout = 2
      @timeout = 5
      @object_struct_responses = true
    end
  end
end
