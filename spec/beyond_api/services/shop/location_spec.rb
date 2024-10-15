# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Location, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all shop locations' do
      response = client.all

      expect(response).to be_present
      expect(response.dig(:embedded, :locations)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with location' do
    before(:each) do
      @location = client.create(build(:location_data))
    end

    after(:each) do
      client.delete(@location[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end

    describe '.create' do
      it 'creates a new shop location' do
        expect(@location).to be_present
        expect(@location[:store_code]).to eq('MLC-St-Ives')
      end
    end

    describe '.find' do
      it 'returns a shop location' do
        response = client.find(@location[:id])
        expect(response[:store_code]).to eq('MLC-St-Ives')
      end
    end

    describe '.update' do
      it 'updates a shop location' do
        updated_location_data = FactoryBot.build(:location_data, :alternative_name)
        response = client.update(@location[:id], updated_location_data)

        expect(response).to be_present
        expect(response[:company_name]).to eq('Updated Cornershop')
      end
    end

    describe '.delete' do
      it 'deletes a shop location' do
        response = client.delete(@location[:id])
        expect(response).to eq({})
      end
    end
  end
end
