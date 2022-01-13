# frozen_string_literal: true

require "json"
require "faraday"
require "beyond_api/utils"

module BeyondApi
  class Request
    class << self
      [:get, :delete].each do |method|
        define_method(method) do |session, path, params = {}|
          response = BeyondApi::Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
            request.params = params.to_h.camelize_keys
          end

          [response.body.blank? ? nil : JSON.parse(response.body), response.status]
        end
      end

      [:post, :put, :patch].each do |method|
        define_method(method) do |session, path, body = {}, params = {}, content_type = 'application/json'|
          response = BeyondApi::Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
            request.headers["Content-Type"] = content_type
            request.params = params.to_h.camelize_keys

            request.body = body.is_a?(String) ? body : body.camelize_keys.to_json
          end

          [response.body.blank? ? nil : JSON.parse(response.body), response.status]
        end
      end
    end

    def self.upload(session, path, file_binary, content_type, params)
      response = BeyondApi::Connection.default.post do |request|
        request.url(session.api_url + path)
        request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
        request.headers["Content-Type"] = content_type
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

    def self.upload_by_form(session, path, files, params)
      response = BeyondApi::Connection.multipart.post do |request|
        request.url(session.api_url + path)
        request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
        request.options[:params_encoder] = Faraday::FlatParamsEncoder
        request.params = params.to_h.camelize_keys
        files = files.split unless files.is_a? Array
        upload_files = files.map{ |file| Faraday::FilePart.new(File.open(file),
                                                               BeyondApi::Utils.file_content_type(file)) }
        request.body = { image: upload_files }
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end
  end
end
