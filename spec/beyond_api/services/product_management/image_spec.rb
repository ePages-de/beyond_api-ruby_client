# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Image, vcr: { match_requests_on: [:method, :uri] } do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }
  let(:product_client) do
    BeyondApi::ProductManagement::Product.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token)
  end

  describe '.all' do
    it 'returns all images' do
      response = client.all('4bf6d53d-dfb2-4468-b6f9-f6e6265bc0bc')

      expect(response).not_to be nil
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  describe '.upload' do
    it 'uploads an image' do
      response = client.upload('4bf6d53d-dfb2-4468-b6f9-f6e6265bc0bc',
                               'spec/files/image1.png',
                               'new-image.png')

      expect(response).not_to be nil
      expect(response.dig(:links, :data, :href)).to include('new-image.png')
    end

    it 'uploads multiple images' do
      response = client.upload_multiple('4bf6d53d-dfb2-4468-b6f9-f6e6265bc0bc',
                                        ['spec/files/image2.png', 'spec/files/image3.png'],
                                        ['new-image2.png', 'new-image3.png'])
      expect(response).not_to be nil
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
    end

    it 'uploads an image from an external URI' do
      response = client.upload_external('4bf6d53d-dfb2-4468-b6f9-f6e6265bc0bc',
                                        'https://epages.com/wp-content/uploads/2019/08/video-thumbnail-sell-online-supportpage_button_2.jpg',
                                        'external-img.jpg')

      expect(response).not_to be nil
      expect(response.dig(:links, :data, :href)).to include('external-img.jpg')
    end
  end

  context 'with own product' do
    before do
      @product = product_client.create(build(:product_data))
    end

    describe '.all' do
      it 'returns an empty page for a product without images' do
        response = client.all(@product[:id], paginated: false)

        expect(response.dig(:embedded, :images)).to eq([])
        expect(response.dig(:page, :total_elements)).to eq(0)
      end
    end

    context 'with images' do
      before do
        @image_ids = ['spec/files/image1.png', 'spec/files/image2.png'].each_with_index.map do |path, index|
          client.upload(@product[:id], path, "sortable-image#{index + 1}.png")[:id]
        end
      end

      describe '.all' do
        it 'honours the requested page size' do
          response = client.all(@product[:id], size: 1)

          expect(response.dig(:embedded, :images).size).to eq(1)
          expect(response.dig(:page, :total_pages)).to eq(2)
        end

        it 'follows every page when paginated is false' do
          # A page size of one spreads the two images over two pages.
          BeyondApi.configuration.all_pagination_size = 1

          response = client.all(@product[:id], paginated: false)

          expect(response.dig(:embedded, :images).map { |image| image[:id] }).to eq(@image_ids)
          expect(response.dig(:page, :total_pages)).to eq(1)
          expect(response.dig(:page, :total_elements)).to eq(2)
        ensure
          BeyondApi.configuration.all_pagination_size = 200
        end
      end

      describe '.sort' do
        it 'reorders the images of a product' do
          client.sort(@product[:id], @image_ids.reverse)

          reordered = client.all(@product[:id]).dig(:embedded, :images).map { |image| image[:id] }
          expect(reordered).to eq(@image_ids.reverse)
        end

        it 'ignores nil image ids' do
          client.sort(@product[:id], [@image_ids.last, nil, @image_ids.first])

          reordered = client.all(@product[:id]).dig(:embedded, :images).map { |image| image[:id] }
          expect(reordered).to eq(@image_ids.reverse)
        end
      end

      describe '.delete' do
        it 'deletes a product image' do
          response = client.delete(@product[:id], @image_ids.first)

          expect(response).to eq({})
          expect(client.all(@product[:id]).dig(:page, :total_elements)).to eq(1)
        end
      end
    end

    after do
      product_client.delete_product(@product[:id])
    rescue StandardError
      BeyondApi::Error
      # Cleanup after each test
    end
  end
end
