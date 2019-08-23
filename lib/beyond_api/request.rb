# frozen_string_literal: true

module BeyondAPI
  class Request
    class << self
      [:get, :delete].each do |method|
        define_method(method) do |session, path, params = {}|
          response = BeyondAPI::Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers['Authorization'] = "Bearer #{ session.access_token }"
            request.params = params
          end

          [response.body.blank? ? nil : JSON.parse(response.body), response.status]
        end
      end

      [:post, :put, :patch].each do |method|
        define_method(method) do |session, path, body = {}|
          response = BeyondAPI::Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers['Authorization'] = "Bearer #{ session.access_token }"
            request.body = body.to_h.camelize_keys.to_json
          end

          [response.body.blank? ? nil : JSON.parse(response.body), response.status]
        end
      end
    end

    def self.token(url, params)
      response = BeyondAPI::Connection.token.post do |request|
        request.url(url)
        request.params = params
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end
  end
end
