# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Image, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all images' do
      response = client.all('4bf6d53d-dfb2-4468-b6f9-f6e6265bc0bc')

      expect(response).not_to be nil
      expect(response.dig(:embedded, :images)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end
end
