# frozen_string_literal: true

require 'webmock'

# Helpers for request-contract specs, which assert *what* the gem puts on the
# wire (path, verb, headers, body) without talking to a live shop. They need
# neither credentials nor a VCR cassette, so they run in any environment.
#
# Tag a describe block with `:stubbed_requests` to use them.
module StubbedRequests
  API_URL      = 'https://stub.example/api'
  ACCESS_TOKEN = 'stub-access-token'

  def stubbed_client(service = described_class)
    service.new(api_url: API_URL, access_token: ACCESS_TOKEN, refresh_token: 'stub-refresh-token')
  end

  # Answers every request to the stub host with `body` and returns the array
  # that each intercepted request is appended to.
  def record_requests(body: '{}', status: 200, content_type: 'application/json')
    requests = []

    WebMock.stub_request(:any, %r{\Ahttps://stub\.example/api}).to_return do |request|
      requests << request
      resolved_body = body.respond_to?(:call) ? body.call(request) : body

      { status:, headers: { 'Content-Type' => content_type }, body: resolved_body }
    end

    requests
  end

  # A HAL collection page, as the Beyond API returns it.
  def page_body(resource_key, ids, total_pages:, total_elements:, number: 0)
    {
      _embedded: { resource_key => ids.map { |id| { _id: id } } },
      page: { size: ids.size, totalElements: total_elements, totalPages: total_pages, number: }
    }.to_json
  end
end

RSpec.configure do |config|
  config.include StubbedRequests, :stubbed_requests
  # Scoped to these specs so the VCR-backed suite keeps managing its own stubs.
  config.after(:each, :stubbed_requests) { WebMock.reset! }
end
