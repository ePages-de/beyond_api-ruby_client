RSpec.describe BeyondApi::ProductManagement::Product, vcr: true do
  let(:client) { described_class.new(api_url: ENV["API_URL"], access_token: auth_client.client_credentials[:access_token]) }

  describe ".all" do
    it "returns all products" do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :products)).to be_kind_of(Array)
      expect(response.dig(:page)).to be_kind_of(Hash)
    end
  end

  context "with product" do
    before(:each) do
      @product = client.create(build(:product_data))
    end

    describe ".create" do
      it "creates a new product" do
        expect(@product).not_to be nil
        expect(@product[:name]).to eq("Team42 Product")
        expect(@product[:essential_features]).to eq("Dry. 12% alcohol. Best vine variety.")
        expect(@product[:tags]).to eq(["Bestseller", "Red Wine", "Sale"])
        expect(@product[:product_identifiers]).to eq([{ type: "EAN", value: "9780134308135" }])
      end
    end

    describe ".find" do
      it "returns a product" do
        response = client.find(@product[:id])
        expect(response[:name]).to eq("Team42 Product")
      end
    end
  end
end
