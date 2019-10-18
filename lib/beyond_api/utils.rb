# frozen_string_literal: true

module BeyondApi
  module Utils
    extend self

    def handle_response(response, status, respond_with_true: false)
      if status.between?(200, 299)
        return true if respond_with_true
        response = sanitize_response(response)
        BeyondApi.configuration.object_struct_responses ? to_object_struct(response) : response
      else
        logger.error "[Beyond API] #{response}" if logger
        BeyondApi::Error.new(response)
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

    def sanitize_response(hash)
      {}.tap do |h|
        hash.each do |key, value|
          next if key == "_links" && BeyondApi.configuration.remove_response_links
          key = sanitize_key(key) if BeyondApi.configuration.remove_response_key_underscores
          h[key.underscore.to_sym] = transform(value)
        end
      end
    end

    def sanitize_key(key)
      key.chars.first == "_" ? key[1..-1] : key
    end

    private

      def transform(thing)
        case thing
        when Hash; sanitize_response(thing)
        when Array; thing.map { |v| transform(v) }
        else; thing
        end
      end
  end
end
