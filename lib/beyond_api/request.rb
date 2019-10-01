# frozen_string_literal: true

require "json"

module BeyondApi
  class Request
    class << self
      [:get, :delete].each do |method|
        define_method(method) do |session, path, params = {}|
          response = BeyondApi::Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers['Authorization'] = "Bearer #{ session.access_token }"
            request.params = params.to_h.camelize_keys
          end

          [response.body.blank? ? nil : JSON.parse(response.body), response.status]
        end
      end

      [:post, :put, :patch].each do |method|
        define_method(method) do |session, path, body = {}, params = {}|
          response = BeyondApi::Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers['Authorization'] = "Bearer #{ session.access_token }"
            request.params = params.to_h.camelize_keys
            request.body = body.to_h.camelize_keys.to_json
          end

          [response.body.blank? ? nil : JSON.parse(response.body), response.status]
        end
      end
    end

    def self.upload(session, path, file_binary, content_type, params)
      response = BeyondApi::Connection.default.post do |request|
        request.url(session.api_url + path)
        request.headers['Authorization'] = "Bearer #{ session.access_token }"
        request.headers['Content-Type'] = content_type
        request.params = params.to_h.camelize_keys
        request.body = file_binary
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end

    def self.token(url, params)
      response = BeyondApi::Connection.token.post do |request|
        request.url(url)
        request.params = params
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end
  end
end
