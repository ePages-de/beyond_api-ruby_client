# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Feature, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all shop features' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :features)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  describe '.find' do
    it 'returns a shop feature' do
      response = client.find('product-management.max-products')
      expect(response[:name]).to eq('product-management.max-products')
    end
  end
end
