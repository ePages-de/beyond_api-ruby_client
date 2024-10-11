# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Attribute, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all shop attributes' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :attributes)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with shop attribute' do
    before(:each) do
      @shop_attribute = client.create('createSku', 'autogenerateSku', true)
    end

    describe '.create' do
      it 'creates a new shop attribute' do
        expect(@shop_attribute).not_to be nil
        expect(@shop_attribute[:name]).to eq('createSku')
        expect(@shop_attribute[:value]).to eq('autogenerateSku')
        expect(@shop_attribute[:public]).to eq(true)
      end
    end

    describe '.find' do
      it 'returns a shop attribute' do
        response = client.find('createSku')
        expect(response[:value]).to eq('autogenerateSku')
      end
    end

    describe '.update' do
      it 'updates an existing shop attribute' do
        response = client.update('createSku', 'autogenerateSku', false)
        expect(response).not_to be nil
        expect(response[:name]).to eq('createSku')
        expect(response[:value]).to eq('autogenerateSku')
        expect(response[:public]).to eq(false)
      end
    end

    describe '.delete' do
      it 'deletes a shop attribute' do
        expect(client.delete('createSku')).to eq({})
      end
    end

    after(:each) do
      client.delete('createSku')
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
