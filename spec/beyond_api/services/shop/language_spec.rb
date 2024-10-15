# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Language, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all shop languages' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :languages)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with language' do
    before(:each) do
      @response = client.create('it-IT')
    end

    describe '.create' do
      it 'creates a new shop language' do
        expect(@response).not_to be nil
        expect(@response[:locale]).to eq('it-IT')
      end
    end

    describe '.find' do
      it 'returns a shop language' do
        response = client.find(@response[:id])
        expect(response[:locale]).to eq('it-IT')
      end
    end

    describe '.delete' do
      it 'deletes a shop language' do
        response = client.delete(@response[:id])
        expect(response).to eq({})
      end
    end
  end
end
