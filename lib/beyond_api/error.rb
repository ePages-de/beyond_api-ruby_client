# frozen_string_literal: true

module BeyondApi
  class Error
    attr_reader :error_id, :details, :message, :trace_id

    def initialize(data)
      @error_id = data['errorId']
      @details = data['details']
      @message = data['message']
      @trace_id = data['traceId']
    end
  end
end
