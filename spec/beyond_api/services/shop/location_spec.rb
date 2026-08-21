# frozen_string_literal: true

RSpec.describe BeyondApi::Shop::Location, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  def delete_location(location)
    client.delete(location[:id])
  rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
  end

  describe '.all' do
    before(:each) do
      @locations = %w[MLC-St-Ives MLC-Penzance MLC-Truro].map do |store_code|
        client.create(build(:location_data, store_code:,
                                            company_name: "My little Cornershop - #{store_code}"))
      end
    end

    after(:each) do
      @locations.each { |location| delete_location(location) }
    end

    it 'returns all shop locations' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :locations)).to be_kind_of(Array)
      expect(response[:page]).to include(:size, :total_elements, :total_pages, :number)
      expect(response.dig(:embedded, :locations).map { |location| location[:store_code] })
        .to eq(%w[MLC-St-Ives MLC-Penzance MLC-Truro])
    end

    it 'honours the requested page size' do
      response = client.all(size: 2)

      expect(response.dig(:embedded, :locations).size).to eq(2)
      expect(response.dig(:page, :size)).to eq(2)
      expect(response.dig(:page, :total_pages)).to eq(2)
    end

    it 'follows every page when paginated is false' do
      # A page size of two spreads the three locations over two pages.
      BeyondApi.configuration.all_pagination_size = 2

      response = client.all(paginated: false)

      expect(response.dig(:embedded, :locations).map { |location| location[:store_code] })
        .to eq(%w[MLC-St-Ives MLC-Penzance MLC-Truro])
      expect(response.dig(:page, :total_pages)).to eq(1)
      expect(response.dig(:page, :total_elements)).to eq(3)
    ensure
      BeyondApi.configuration.all_pagination_size = 200
    end
  end

  context 'with location' do
    before(:each) do
      @location = client.create(build(:location_data))
    end

    after(:each) do
      delete_location(@location)
    end

    describe '.create' do
      it 'creates a new shop location' do
        expect(@location).not_to be nil
        expect(@location[:id]).to be_present
        expect(@location[:store_code]).to eq('MLC-St-Ives')
        expect(@location[:company_name]).to eq('My little Cornershop - St.Ives')
        expect(@location[:google_status]).to eq('ACTIVE')
        expect(@location[:address]).to include(street: 'Hudson Way', house_number: '27', city: 'St.Ives',
                                               postal_code: '90999', country: 'GB', state: 'Cornwall')
        expect(@location[:lat_lng]).to eq(latitude: 53.5847424, longitude: 9.968901)
      end

      it 'raises an error when the location is invalid' do
        expect do
          client.create(build(:location_data, :without_store_code))
        end.to raise_error(BeyondApi::Error, /input-validation-failed/)
      end
    end

    describe '.find' do
      it 'returns a shop location' do
        response = client.find(@location[:id])

        expect(response[:id]).to eq(@location[:id])
        expect(response[:store_code]).to eq('MLC-St-Ives')
        expect(response.dig(:regular_hours, :periods).map { |period| period[:open_day] })
          .to eq(%w[MONDAY SATURDAY])
        expect(response.dig(:google_primary_category, :display_name)).to eq('Food')
      end

      it 'raises an error when the location does not exist' do
        expect do
          client.find('00000000-0000-0000-0000-000000000000')
        end.to raise_error(BeyondApi::Error)
      end
    end

    describe '.update' do
      it 'updates a shop location' do
        response = client.update(@location[:id], build(:location_data, :alternative_name))

        expect(response).not_to be nil
        expect(response[:id]).to eq(@location[:id])
        expect(response[:company_name]).to eq('Updated Cornershop')
        expect(response[:store_code]).to eq('MLC-St-Ives')
      end
    end

    describe '.delete' do
      it 'deletes a shop location' do
        response = client.delete(@location[:id])

        expect(response).to eq({})
        expect { client.find(@location[:id]) }.to raise_error(BeyondApi::Error)
      end
    end
  end
end
