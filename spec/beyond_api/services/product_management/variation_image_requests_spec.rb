# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::VariationImage, :stubbed_requests do
  let(:client) { stubbed_client }
  let(:product_id) { '4125b993-49fc-47c8-b9b3-76d8871e4e06' }
  let(:variation_id) { 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' }
  let(:image_id) { 'b2c3d4e5-f678-90ab-cdef-1234567890ab' }
  let(:images_path) { "/api/products/#{product_id}/variations/#{variation_id}/images" }

  describe '.upload' do
    it 'POSTs the raw image bytes with the file content type' do
      requests = record_requests

      client.upload(product_id, variation_id, 'spec/files/image1.png', 'new-image.png')

      request = requests.first
      expect(request.method).to eq(:post)
      expect(request.uri.path).to eq(images_path)
      expect(request.uri.query_values).to eq('fileName' => 'new-image.png')
      expect(request.headers['Content-Type']).to eq('image/png')
      expect(request.body).to eq(File.binread('spec/files/image1.png'))
    end
  end

  describe '.upload_multiple' do
    it 'uploads each image in its own request' do
      requests = record_requests

      client.upload_multiple(product_id, variation_id,
                             ['spec/files/image2.png', 'spec/files/image3.png'],
                             ['new-image2.png', 'new-image3.png'])

      expect(requests.map { |request| request.uri.query_values['fileName'] }).to eq(['new-image2.png',
                                                                                     'new-image3.png'])
      expect(requests.map(&:method).uniq).to eq([:post])
    end

    it 'returns one response per uploaded image' do
      record_requests

      response = client.upload_multiple(product_id, variation_id, ['spec/files/image2.png'], ['new-image2.png'])

      expect(response.size).to eq(1)
    end
  end

  describe '.delete' do
    it 'issues a DELETE to the variation image resource' do
      requests = record_requests

      client.delete(product_id, variation_id, image_id)

      expect(requests.size).to eq(1)
      expect(requests.first.method).to eq(:delete)
      expect(requests.first.uri.path).to eq("#{images_path}/#{image_id}")
    end
  end

  describe '.sort' do
    let(:second_image_id) { 'c3d4e5f6-7890-abcd-ef12-34567890abcd' }

    it 'PUTs the image URIs as a text/uri-list body' do
      requests = record_requests

      client.sort(product_id, variation_id, [image_id, second_image_id])

      request = requests.first
      expect(request.method).to eq(:put)
      expect(request.uri.path).to eq(images_path)
      expect(request.headers['Content-Type']).to eq('text/uri-list')
      expect(request.body.split("\n")).to eq(
        ["#{StubbedRequests::API_URL}/products/#{product_id}/variations/#{variation_id}/images/#{image_id}",
         "#{StubbedRequests::API_URL}/products/#{product_id}/variations/#{variation_id}/images/#{second_image_id}"]
      )
    end
  end

  describe '.all' do
    it 'follows every page when paginated is false' do
      pages = [%w[img-1 img-2], %w[img-3]]
      requests = record_requests(body: ->(request) {
        number = request.uri.query_values['page'].to_i
        page_body(:images, pages[number], total_pages: 2, total_elements: 3, number:)
      })

      response = client.all(product_id, variation_id, paginated: false)

      expect(requests.size).to eq(2)
      expect(response.dig(:embedded, :images).map { |image| image[:id] }).to eq(%w[img-1 img-2 img-3])
    end

    it 'passes the page size through' do
      requests = record_requests(body: page_body(:images, %w[img-1], total_pages: 1, total_elements: 1))

      client.all(product_id, variation_id, size: 5)

      expect(requests.first.uri.query_values).to eq('size' => '5')
    end
  end
end
