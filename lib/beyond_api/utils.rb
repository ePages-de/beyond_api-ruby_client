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
        handle_error(response, status)
      end
    end

    def handle_error(response, status)
      BeyondApi.logger.error "[Beyond API] #{status}: #{response}"
      error = BeyondApi::Error.new(response, status)
      BeyondApi.configuration.raise_error_requests ? raise(error) : error
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

    def handle_all_request(url, resource, params = {})

      if params[:paginated] == false
        result = all_paginated(url, params.merge(page: 0, size: 1000))

        (1..result[:page][:total_pages] - 1).each do |page|
          result[:embedded][resource].concat(all_paginated(url, params.merge(page: page, size: 1000))[:embedded][resource])
        end

        result[:page][:size] = result[:page][:total_elements]
        result[:page][:total_pages] = 1
        result[:page][:number] = 0

        result
      else
        all_paginated(url, params)
      end
    end

    private

      def transform(thing)
        case thing
        when Hash; sanitize_response(thing)
        when Array; thing.map { |v| transform(v) }
        else; thing
        end
      end

      def all_paginated(url, params = {})
        response, status = BeyondApi::Request.get(@session, url, params)

        handle_response(response, status)
      end
  end
end
