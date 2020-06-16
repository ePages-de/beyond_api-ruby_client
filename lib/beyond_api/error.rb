# frozen_string_literal: true

module BeyondApi
  class Error < StandardError
    attr_reader :error_id, :details, :trace_id, :full_message, :status_code, :error, :error_description

    def initialize(data, status_code = nil)
      @error_id          = data['errorId']
      @details           = data['details']
      @trace_id          = data['traceId']
      @error             = data['error']
      @error_description = data['error_description']
      @full_message      = data
      @status_code       = status_code

      super(data['message'] || data['error_description'])
    end
  end
end
