RSpec.describe BeyondApi::Shop::Address, vcr: true do
  let(:client) { described_class.new(api_url: ENV["API_URL"], access_token: auth_client.client_credentials[:access_token]) }

  describe ".get" do
    it "returns the shop address" do
      response = client.show
      expect(response).not_to be nil
      expect(response.keys).to include(:company, :first_name, :last_name, :email,
                                       :phone, :street, :postal_code, :dependent_locality, :city, :state, :country)
    end
  end
end
