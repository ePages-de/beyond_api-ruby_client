# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::VariationImage, vcr: { match_requests_on: [:method, :uri] } do
  let(:access_token) { beyond_access_token }
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token:) }
  let(:product_client) do
    BeyondApi::ProductManagement::Product.new(api_url: ENV.fetch('API_URL', nil), access_token:)
  end
  let(:variation_client) do
    BeyondApi::ProductManagement::Variation.new(api_url: ENV.fetch('API_URL', nil), access_token:)
  end
  let(:external_image_uri) do
    'https://epages.com/wp-content/uploads/2019/08/video-thumbnail-sell-online-supportpage_button_2.jpg'
  end

  before do
    @product = product_client.create_variation(build(:variation_product_data, :single_attribute))
    # Images can only be attached to variations once `defaultImage` is a variation property.
    product_client.update_variation_properties(@product[:id], [{ property: 'defaultImage', enabled: true }])
    @variation_id = variation_client.all(@product[:id]).dig(:embedded, :variations).first[:id]
  end

  describe '.upload_external' do
    it 'uploads an image from an external URI' do
      response = client.upload_external(@product[:id], @variation_id, external_image_uri, 'external-var.jpg')

      expect(response).not_to be nil
      expect(response[:id]).not_to be nil
      expect(response.dig(:links, :data, :href)).to include('external-var.jpg')
      expect(response[:width]).to be_kind_of(Integer)
      expect(response[:height]).to be_kind_of(Integer)
    end

    it 'adds the image to the variation' do
      client.upload_external(@product[:id], @variation_id, external_image_uri, 'external-var.jpg')

      response = client.all(@product[:id], @variation_id)

      expect(response.dig(:page, :total_elements)).to eq(1)
    end
  end

  describe '.upload' do
    it 'uploads an image from a local file' do
      response = client.upload(@product[:id], @variation_id, 'spec/files/image1.png', 'var-image1.png')

      expect(response).not_to be nil
      expect(response.dig(:links, :data, :href)).to include('var-image1.png')
      expect(response[:position]).to eq(0)
    end
  end

  describe '.upload_multiple' do
    it 'uploads each image and returns one response per image' do
      response = client.upload_multiple(@product[:id], @variation_id,
                                        ['spec/files/image2.png', 'spec/files/image3.png'],
                                        ['var-image2.png', 'var-image3.png'])

      expect(response.size).to eq(2)
      expect(response.map { |image| image.dig(:links, :data, :href) })
        .to all(be_kind_of(String))
      expect(client.all(@product[:id], @variation_id).dig(:page, :total_elements)).to eq(2)
    end
  end

  describe '.all' do
    it 'returns the images of a variation' do
      client.upload(@product[:id], @variation_id, 'spec/files/image1.png', 'var-image1.png')

      response = client.all(@product[:id], @variation_id)

      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
      expect(response[:page]).to include(:size, :total_elements, :total_pages, :number)
    end
  end

  describe '.sort' do
    it 'reorders the images of a variation' do
      client.upload(@product[:id], @variation_id, 'spec/files/image1.png', 'var-image1.png')
      client.upload(@product[:id], @variation_id, 'spec/files/image2.png', 'var-image2.png')
      ids = client.all(@product[:id], @variation_id).dig(:embedded, :images).map { |image| image[:id] }

      client.sort(@product[:id], @variation_id, ids.reverse)

      reordered = client.all(@product[:id], @variation_id).dig(:embedded, :images).map { |image| image[:id] }
      expect(reordered).to eq(ids.reverse)
    end
  end

  describe '.delete' do
    it 'deletes an image of a variation' do
      image = client.upload(@product[:id], @variation_id, 'spec/files/image1.png', 'var-image1.png')

      response = client.delete(@product[:id], @variation_id, image[:id])

      expect(response).to eq({})
      expect(client.all(@product[:id], @variation_id).dig(:page, :total_elements)).to eq(0)
    end
  end

  after do
    product_client.delete_product(@product[:id])
  rescue StandardError
    BeyondApi::Error
    # Cleanup after each test
  end
end
