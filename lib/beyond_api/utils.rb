# frozen_string_literal: true

module BeyondAPI
  module Utils

    def handle_response(response, status, respond_with_true: false)
      response = response.rubify
      if status.between?(200, 299)
        return true if respond_with_true
        if BeyondAPI.configuration.object_struct_responses
          to_object_struct(response)
        else
          response
        end
      else
        puts response
        # BeyondAPI::Error.new(response)
      end
    end

    def to_object_struct(data)
      if data.is_a? Hash
        return OpenStruct.new(data.map { |key, val| [key, to_object_struct(val)] }.to_h)
      elsif data.is_a? Array
        return data.map { |o| to_object_struct(o) }
      else
        return data
      end
    end
  end
end
