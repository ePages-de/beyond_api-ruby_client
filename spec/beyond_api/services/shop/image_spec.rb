# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Image, vcr: { match_requests_on: [:method, :uri] } do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all shop images' do
      response = client.all
      puts response.dig(:embedded, :images).first[:id]

      expect(response).not_to be nil
      puts response.dig(:embedded, :images)
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  describe '.find_by_label' do
    it 'finds a shop image by label' do
      response = client.find_by_label('logo')

      expect(response).not_to be nil
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
    end
  end

  context 'with a shop image' do
    before(:each) do
      @image = client.upload('spec/files/image1.png', 'new-image.png', 'logo')
    end

    describe '.upload' do
      it 'uploads an image' do
        expect(@image).not_to be nil
        expect(@image.dig(:links, :data, :href)).to include('new-image.png')
      end
    end

    describe '.find' do
      it 'finds a shop image' do
        response = client.find(@image[:id])

        expect(response).not_to be nil
        expect(response[:id]).to eq(@image[:id])
      end
    end

    describe '.delete' do
      it 'deletes a shop image' do
        expect(client.delete(@image[:id])).to eq({})
      end
    end

    after(:each) do
      client.delete(@image[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
