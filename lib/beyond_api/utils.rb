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
        BeyondApi.logger.error "[Beyond API] #{response}"
        BeyondApi.configuration.raise_error_requests ? raise(response.to_s) : BeyondApi::Error.new(response)
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

    def all_results(url, resource, params = {})
      if params[:paginated] == false
        result = all_paginated(url, { page: 0, size: 1000 })

        (1..result[:page][:total_pages] - 1).each do |page|
          result[:embedded][resource].concat(all_paginated(url, { page: page, size: 1000 })[:embedded][resource])
        end

        result.is_a?(Hash) ? result.delete(:page) : result.delete_field(:page)

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
