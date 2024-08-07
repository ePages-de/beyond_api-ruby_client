# frozen_string_literal: true

module BeyondApi
  class Request
    def initialize(session, connection = Connection.default)
      @session = session
      @connection = connection
    end

    def get(path, params = {})
      send_request(
        :get,
        path,
        params: params
        )
    end

    def delete(path, params = {})
      send_request(
        :delete,
        path,
        params: params
        )
    end

    def post(path, body = {}, params = {}, content_type = 'application/json')
      send_request(
        :post,
        path,
        body: body, params: params, content_type: content_type
        )
    end

    def put(path, body = {}, params = {}, content_type = 'application/json')
      send_request(
        :put,
        path,
        body: body, params: params, content_type: content_type
        )
    end

    def patch(path, body = {}, params = {}, content_type = 'application/json')
      send_request(
        :patch,
        path,
        body: body, params: params, content_type: content_type
        )
    end

    def upload(path, file_binary, content_type, params)
      send_request(
        :post,
        path,
        body: file_binary, params: params, content_type: content_type
        )
    end

    def upload_by_form(path, files, params)
      files = files.split unless files.is_a?(Array)
      upload_files = files.map { |file| Faraday::FilePart.new(File.open(file), Utils.file_content_type(file)) }
      send_request(:post, path, body: { image: upload_files }, params: params, content_type: 'multipart/form-data')
    end

    def self.token(url, params)
      response = Connection.token.post do |request|
        request.url(url)
        request.params = params
      end

      [response.body.blank? ? nil : JSON.parse(response.body), response.status]
    end

    private

    def send_request(method, path, body: {}, params: {}, content_type: 'application/json')
      response = Connection.default.send(method) do |request|
        request.url(@session.api_url + path)
        request.headers["Authorization"] = "Bearer #{@session.access_token}" unless @session.access_token.nil?
        request.headers["Content-Type"] = content_type if method != :get
        request.params = Utils.camelize_keys(params)
        request.body = Utils.camelize_keys(body) if method != :get
      end

      Response.new(response).handle
    rescue Faraday::ConnectionFailed, Faraday::TimeoutError => e
      raise(FaradayError.new(e, 599))
    end
  end
end
