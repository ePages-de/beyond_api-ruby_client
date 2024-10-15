# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Shop, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.get' do
    it 'returns the shop details' do
      response = client.show
      expect(response).not_to be nil
      expect(response.keys).to include(:name, :reseller_name, :primary_hostname, :default_locale)
    end
  end
end
