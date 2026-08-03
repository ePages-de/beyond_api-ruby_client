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

    it 'honours the requested page size' do
      client.upload_multiple(@product[:id], @variation_id,
                             ['spec/files/image1.png', 'spec/files/image2.png'],
                             ['var-image1.png', 'var-image2.png'])

      response = client.all(@product[:id], @variation_id, size: 1)

      expect(response.dig(:embedded, :images).size).to eq(1)
      expect(response.dig(:page, :total_pages)).to eq(2)
    end

    it 'follows every page when paginated is false' do
      image_ids = client.upload_multiple(@product[:id], @variation_id,
                                         ['spec/files/image1.png', 'spec/files/image2.png'],
                                         ['var-image1.png', 'var-image2.png']).map { |image| image[:id] }
      # A page size of one spreads the two images over two pages.
      BeyondApi.configuration.all_pagination_size = 1

      response = client.all(@product[:id], @variation_id, paginated: false)

      expect(response.dig(:embedded, :images).map { |image| image[:id] }).to eq(image_ids)
      expect(response.dig(:page, :total_pages)).to eq(1)
      expect(response.dig(:page, :total_elements)).to eq(2)
    ensure
      BeyondApi.configuration.all_pagination_size = 200
    end
  end

  describe '.sort' do
    # Cassettes are matched on method and URI only, because the multipart upload bodies
    # carry a per-request boundary. Sorting lives entirely in the request body, so the
    # order reaching the wire is asserted here rather than inferred from a later read.
    def expect_sorted_uri_list(order)
      expect(client).to have_received(:put_uri_list).with(
        "products/#{@product[:id]}/variations/#{@variation_id}/images",
        order.map do |image_id|
          "#{ENV.fetch('API_URL', nil)}/products/#{@product[:id]}/variations/#{@variation_id}/images/#{image_id}"
        end
      )
    end

    def upload_three_images
      client.upload(@product[:id], @variation_id, 'spec/files/image1.png', 'var-image1.png')
      client.upload(@product[:id], @variation_id, 'spec/files/image2.png', 'var-image2.png')
      client.upload(@product[:id], @variation_id, 'spec/files/image3.png', 'var-image3.png')

      client.all(@product[:id], @variation_id).dig(:embedded, :images).map { |image| image[:id] }
    end

    before { allow(client).to receive(:put_uri_list).and_call_original }

    it 'reorders the images of a variation' do
      ids = upload_three_images
      # A rotation rather than a reversal, so an implementation that simply
      # inverted the given order would not satisfy the expectation.
      desired_order = [ids[1], ids[2], ids[0]]

      client.sort(@product[:id], @variation_id, desired_order)

      expect_sorted_uri_list(desired_order)
      reordered = client.all(@product[:id], @variation_id).dig(:embedded, :images).map { |image| image[:id] }
      expect(reordered).to eq(desired_order)
    end

    it 'ignores nil image ids' do
      ids = upload_three_images

      client.sort(@product[:id], @variation_id, [ids[2], nil, ids[0], nil, ids[1]])

      expected_order = [ids[2], ids[0], ids[1]]

      expect_sorted_uri_list(expected_order)
      reordered = client.all(@product[:id], @variation_id).dig(:embedded, :images).map { |image| image[:id] }
      expect(reordered).to eq(expected_order)
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
