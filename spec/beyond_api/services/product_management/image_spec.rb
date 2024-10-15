# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Image, vcr: { match_requests_on: [:method, :uri] } do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

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
  end
end
