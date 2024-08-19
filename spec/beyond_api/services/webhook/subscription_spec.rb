RSpec.describe BeyondApi::Webhook::Subscription, vcr: true do
  let(:client) { described_class.new(api_url: ENV["API_URL"], access_token: beyond_access_token) }

  describe ".all" do
    it "returns all webhook subscriptions" do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :subscriptions)).to be_kind_of(Array)
      expect(response.dig(:page)).to be_kind_of(Hash)
    end
  end

  context "with webhook subscription" do
    before(:each) do
      @webhook_subscription = client.create(build(:webhook_data))
    end

    describe ".create" do
      it "creates a new webhook subscription" do
        expect(@webhook_subscription).not_to be nil
        expect(@webhook_subscription[:callback_uri]).to eq("http://example.com/test")
        expect(@webhook_subscription[:event_types]).to eq(["order.created", "product.created"])
      end
    end

    describe ".find" do
      it "returns a webhook subscription" do
        response = client.find(@webhook_subscription[:id])
        expect(response[:callback_uri]).to eq("http://example.com/test")
      end
    end

    describe ".destroy" do
      it "deletes a webhook subscription" do
        response = client.destroy(@webhook_subscription[:id])
        expect(response).to be {}
      end
    end

    after(:each) do
      client.destroy(@webhook_subscription[:id])
    rescue BeyondApi::Error
    end
  end
end
