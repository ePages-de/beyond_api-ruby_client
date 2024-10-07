# frozen_string_literal: true

RSpec.describe BeyondApi::Webhook::Subscription, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all webhook subscriptions' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :subscriptions)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with webhook subscription' do
    before(:each) do
      @webhook_subscription = client.create(build(:webhook_data))
    end

    describe '.create' do
      it 'creates a new webhook subscription' do
        expect(@webhook_subscription).not_to be nil
        expect(@webhook_subscription[:callback_uri]).to eq('http://example.com/test')
        expect(@webhook_subscription[:event_types]).to eq(['order.created', 'product.created'])
      end
    end

    describe '.find' do
      it 'returns a webhook subscription' do
        response = client.find(@webhook_subscription[:id])
        expect(response[:callback_uri]).to eq('http://example.com/test')
      end
    end

    describe '.delete' do
      it 'deletes a webhook subscription' do
        response = client.delete(@webhook_subscription[:id])
        expect(response).to eq({})
      end
    end

    describe '.deactivate' do
      it 'deactivates a webhook subscription' do
        response = client.deactivate(@webhook_subscription[:id])
        expect(response).not_to be nil
        expect(response[:active]).to eq(false)
      end
    end

    describe '.activate' do
      it 'activates a webhook subscription' do
        response = client.activate(@webhook_subscription[:id])
        expect(response).not_to be nil
        expect(response[:active]).to eq(true)
      end
    end

    describe '.failures' do
      it 'lists all failed deliveries of a webhook subscription' do
        response = client.failures(@webhook_subscription[:id], { size: 100, page: 0 })
        expect(response).not_to be nil
        expect(response.dig(:embedded, :failures)).to be_kind_of(Array)
      end
    end

    describe '.retry' do
      it 'retries a failed webhook delivery' do
        failure_id = '987e6543-e21b-45d3-b123-654321098765'
        # Non existing failure ID will raise an error
        expect { client.retry(@webhook_subscription[:id], failure_id) }.to raise_error(BeyondApi::Error)
      end
    end

    describe '.delete_failure' do
      it 'deletes a webhook failure' do
        failure_id = '123e4567-e89b-12d3-a456-426614174000'
        # Non existing failure ID will raise an error
        expect { client.delete_failure(@webhook_subscription[:id], failure_id) }.to raise_error(BeyondApi::Error)
      end
    end

    after(:each) do
      client.delete(@webhook_subscription[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
