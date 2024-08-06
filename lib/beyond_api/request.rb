# frozen_string_literal: true

module BeyondApi
  class Request
    class << self
      [:get, :delete].each do |method|
        define_method(method) do |session, path, params = {}|
          response = Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
            request.params = Utils.camelize_keys(params)
          end

          Response.new(response).handle
        rescue Faraday::ConnectionFailed, Faraday::TimeoutError => e
          raise(FaradayError.new(e, 599))
        end
      end

      [:post, :put, :patch].each do |method|
        define_method(method) do |session, path, body = {}, params = {}, content_type = 'application/json'|
          response = Connection.default.send(method) do |request|
            request.url(session.api_url + path)
            request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
            request.headers["Content-Type"] = content_type
            request.params = Utils.camelize_keys(params)

            request.body = Utils.camelize_keys(body).to_json
          end

          Response.new(response).handle
        end
      end
    end

    def self.upload(session, path, file_binary, content_type, params)
      response = Connection.default.post do |request|
        request.url(session.api_url + path)
        request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
        request.headers["Content-Type"] = content_type
        request.params = Utils.camelize_keys(params)

        request.body = file_binary
      end

      Response.new(response)
    end

    def self.token(url, params)
      response = Connection.token.post do |request|
        request.url(url)
        request.params = params
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end

    def self.upload_by_form(session, path, files, params)
      response = Connection.multipart.post do |request|
        request.url(session.api_url + path)
        request.headers["Authorization"] = "Bearer #{session.access_token}" unless session.access_token.nil?
        request.options[:params_encoder] = Faraday::FlatParamsEncoder

        request.params = Utils.camelize_keys(params)
        
        files = files.split unless files.is_a? Array
        upload_files = files.map{ |file| Faraday::FilePart.new(File.open(file),
                                                               Utils.file_content_type(file)) }
        request.body = { image: upload_files }
      end

      Response.new(response)
    end
  end
end
