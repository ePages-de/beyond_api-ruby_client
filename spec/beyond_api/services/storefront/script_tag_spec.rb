RSpec.describe BeyondApi::Storefront::ScriptTag, vcr: true do
  let(:client) { described_class.new(api_url: ENV["API_URL"], access_token: beyond_access_token) }

  describe ".all" do
    it "returns all script tags" do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :script_tags)).to be_kind_of(Array)
      expect(response.dig(:page)).to be_kind_of(Hash)
    end
  end

  context "with script tag" do
    before(:each) do
      @script_tag = client.create("https://example.com/scripts/exampleScript.js")
    end

    describe ".create" do
      it "creates a new category" do
        expect(@script_tag).not_to be nil
        expect(@script_tag[:script_url]).to eq("https://example.com/scripts/exampleScript.js")
      end
    end

    describe ".delete" do
      it "deletes a script tag" do
        response = client.delete(@script_tag[:id])
        expect(response).to be {}
      end
    end

    after(:each) do
      client.delete(@script_tag[:id])
    rescue BeyondApi::Error
    end
  end
end
