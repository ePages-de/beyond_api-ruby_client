# frozen_string_literal: true

module BeyondApi
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
