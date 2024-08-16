RSpec.describe 'BeyondApi::ProductManagement::Category', vcr: true do
  let(:client) do
    BeyondApi::ProductManagement::Category.new(
      api_url: ENV["API_URL"],
      access_token: auth_client.client_credentials[:access_token]
    )
  end

  describe ".all" do
    it "returns all categories" do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :categories)).to be_kind_of(Array)
      expect(response.dig(:page)).to be_kind_of(Hash)
    end
  end

  context "with category" do
    before(:each) do
      @category = client.create(
        name: "Team42 Category",
        type: "SMART",
        default_sort: "HIGHEST_PRICE_FIRST"
      )
    end

    describe ".find" do
      it "returns a category" do
        response = client.find(@category[:id])
        expect(response[:name]).to eq("Team42 Category")
      end
    end

    describe ".create" do
      it "creates a new category" do
        expect(@category).not_to be nil
        expect(@category[:name]).to eq("Team42 Category")
        expect(@category[:type]).to eq("SMART")
        expect(@category[:default_sort]).to eq("HIGHEST_PRICE_FIRST")
      end
    end

    describe ".update" do
      it "updates an existing category" do
        updated_category_data = {
          name: "Updated Test Category",
          type: "SMART",
          default_sort: "LOWEST_PRICE_FIRST"
        }

        updated_category = client.update(@category[:id], updated_category_data)
        expect(updated_category).not_to be nil
        expect(updated_category[:name]).to eq("Updated Test Category")
        expect(updated_category[:default_sort]).to eq("LOWEST_PRICE_FIRST")
      end
    end

    describe ".destroy" do
      it "deletes a category" do
        response = client.destroy(@category[:id])
        expect(response).to be {}
      end
    end

    after(:each) do
      client.destroy(@category[:id])
    rescue BeyondApi::Error
    end
  end
end