RSpec.describe BeyondApi::Checkout::ShippingZone, vcr: true do
  let(:client) { described_class.new(api_url: ENV["API_URL"], access_token: beyond_access_token) }

  describe ".all" do
    it "returns all shipping_zones" do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :shipping_zones)).to be_kind_of(Array)
      expect(response.dig(:page)).to be_kind_of(Hash)
    end
  end
end
