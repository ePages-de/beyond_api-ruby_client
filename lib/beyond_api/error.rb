# frozen_string_literal: true

module BeyondApi
  class Error < StandardError
    attr_reader :error_id, :details, :trace_id, :full_message, :status_code

    def initialize(data, status_code = nil)
      @error_id     = data['errorId']
      @details      = data['details']
      @trace_id     = data['traceId']
      @full_message = data
      @status_code  = status_code

      super(data['message'])
    end
  end
end
