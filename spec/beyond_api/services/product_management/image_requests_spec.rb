# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Image, :stubbed_requests do
  let(:client) { stubbed_client }
  let(:product_id) { '4125b993-49fc-47c8-b9b3-76d8871e4e06' }
  let(:image_id) { 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' }

  describe '.delete' do
    it 'issues a DELETE to the image resource' do
      requests = record_requests

      client.delete(product_id, image_id)

      expect(requests.size).to eq(1)
      expect(requests.first.method).to eq(:delete)
      expect(requests.first.uri.path).to eq("/api/products/#{product_id}/images/#{image_id}")
    end
  end

  describe '.sort' do
    let(:second_image_id) { 'b2c3d4e5-f678-90ab-cdef-1234567890ab' }

    it 'PUTs the image URIs as a text/uri-list body' do
      requests = record_requests

      client.sort(product_id, [image_id, second_image_id])

      request = requests.first
      expect(request.method).to eq(:put)
      expect(request.uri.path).to eq("/api/products/#{product_id}/images")
      expect(request.headers['Content-Type']).to eq('text/uri-list')
      expect(request.body.split("\n")).to eq(
        ["#{StubbedRequests::API_URL}/products/#{product_id}/images/#{image_id}",
         "#{StubbedRequests::API_URL}/products/#{product_id}/images/#{second_image_id}"]
      )
    end

    it 'sends the bearer token' do
      requests = record_requests

      client.sort(product_id, [image_id])

      expect(requests.first.headers['Authorization']).to eq("Bearer #{StubbedRequests::ACCESS_TOKEN}")
    end

    it 'skips nil image ids' do
      requests = record_requests

      client.sort(product_id, [image_id, nil])

      expect(requests.first.body.split("\n").size).to eq(1)
    end
  end

  describe '.all' do
    it 'follows every page when paginated is false' do
      pages = [%w[img-1 img-2], %w[img-3]]
      requests = record_requests(body: ->(request) {
        number = request.uri.query_values['page'].to_i
        page_body(:images, pages[number], total_pages: 2, total_elements: 3, number:)
      })

      response = client.all(product_id, paginated: false)

      expect(requests.size).to eq(2)
      expect(response.dig(:embedded, :images).map { |image| image[:id] }).to eq(%w[img-1 img-2 img-3])
    end

    it 'returns a single page by default' do
      requests = record_requests(body: page_body(:images, %w[img-1], total_pages: 2, total_elements: 3))

      client.all(product_id)

      expect(requests.size).to eq(1)
    end

    it 'handles an empty collection, which carries no _embedded key' do
      body = { page: { size: 200, totalElements: 0, totalPages: 0, number: 0 } }.to_json
      record_requests(body:)

      response = client.all(product_id, paginated: false)

      expect(response[:embedded]).to be_nil
      expect(response.dig(:page, :total_elements)).to eq(0)
    end
  end
end
