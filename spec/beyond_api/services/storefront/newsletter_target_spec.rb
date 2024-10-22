# frozen_string_literal: true

RSpec.describe BeyondApi::Storefront::NewsletterTarget, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  context 'with newsletter target' do
    before(:each) do
      @newsletter_target = client.create('https://example.com/cgi-bin/subscribe.php')
    end

    describe '.create' do
      it 'creates a new newsletter target' do
        expect(@newsletter_target).not_to be nil
        expect(@newsletter_target[:submit_url]).to eq('https://example.com/cgi-bin/subscribe.php')
      end
    end

    describe '.delete' do
      it 'deletes a newsletter target' do
        response = client.delete(@newsletter_target[:id])
        expect(response).to eq({})
      end
    end

    describe '.show' do
      it 'returns a newsletter target' do
        response = client.show(@newsletter_target[:id])

        expect(response).not_to be nil
        expect(response[:submit_url]).to eq('https://example.com/cgi-bin/subscribe.php')
      end
    end

    describe '.update' do
      it 'updates a newsletter target' do
        response = client.update(@newsletter_target[:id], 'https://example.com/cgi-bin/otherSubscribe.php')

        expect(response).not_to be nil
        expect(response[:submit_url]).to eq('https://example.com/cgi-bin/otherSubscribe.php')
      end
    end

    after(:each) do
      client.delete(@newsletter_target[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
