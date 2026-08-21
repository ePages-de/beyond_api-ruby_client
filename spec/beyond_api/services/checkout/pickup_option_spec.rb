# frozen_string_literal: true

RSpec.describe BeyondApi::Checkout::PickupOption, vcr: true do
  let(:access_token) { beyond_access_token }
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token:) }
  let(:location_client) { BeyondApi::Shop::Location.new(api_url: ENV.fetch('API_URL', nil), access_token:) }

  # Every pickup option needs a location of its own, because a location can only
  # back a single pickup option.
  def create_pickup_option(store_code, attributes = {})
    location = location_client.create(build(:location_data, store_code:,
                                                            company_name: "My little Cornershop - #{store_code}"))
    @locations << location

    client.create(build(:pickup_option_data, location_id: location[:id], **attributes)).tap do |pickup_option|
      @pickup_options << pickup_option
    end
  end

  def delete_pickup_option(pickup_option)
    client.delete(pickup_option[:id])
    # A shop without shipping methods must keep at least one pickup option; that
    # 409 is a retry status, so it surfaces as a Faraday error, not a
    # BeyondApi::Error.
  rescue BeyondApi::Error, Faraday::RetriableResponse # rubocop:disable Lint/SuppressedException
  end

  def delete_location(location)
    location_client.delete(location[:id])
  rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
  end

  # The shop is not assumed to be empty, so expectations are made against the
  # pickup options created by the example rather than against the whole shop.
  def pickup_option_names
    @pickup_options.map { |pickup_option| pickup_option[:name] }
  end

  # `size` is raised above the default page size so that sorting, which applies
  # to a single page, covers every pickup option of the shop.
  def listed_pickup_options
    client.all(size: 100).dig(:embedded, :pickup_options)
  end

  before(:each) do
    @locations = []
    @pickup_options = []
  end

  # Locations are released after the pickup options referencing them.
  after(:each) do
    @pickup_options.each { |pickup_option| delete_pickup_option(pickup_option) }
    @locations.each { |location| delete_location(location) }
  end

  describe '.all' do
    before(:each) do
      %w[MLC-St-Ives MLC-Penzance MLC-Truro].each do |store_code|
        create_pickup_option(store_code, name: "My little Cornershop - #{store_code}")
      end
    end

    it 'returns all pickup options' do
      response = client.all(size: 100)

      expect(response).not_to be nil
      expect(response.dig(:embedded, :pickup_options)).to be_kind_of(Array)
      expect(response[:page]).to include(:size, :total_elements, :total_pages, :number)
      expect(response.dig(:embedded, :pickup_options).map { |pickup_option| pickup_option[:name] })
        .to include(*pickup_option_names)
    end

    it 'honours the requested page size' do
      response = client.all(size: 2)

      expect(response.dig(:embedded, :pickup_options).size).to eq(2)
      expect(response.dig(:page, :size)).to eq(2)
      # The three pickup options of this example alone already spread over two pages.
      expect(response.dig(:page, :total_pages)).to be >= 2
    end

    it 'follows every page when paginated is false' do
      # A page size of two spreads the pickup options over several pages.
      BeyondApi.configuration.all_pagination_size = 2

      response = client.all(paginated: false)

      expect(response.dig(:embedded, :pickup_options).map { |pickup_option| pickup_option[:name] })
        .to include(*pickup_option_names)
      expect(response.dig(:embedded, :pickup_options).size).to eq(response.dig(:page, :total_elements))
      expect(response.dig(:page, :total_pages)).to eq(1)
    ensure
      BeyondApi.configuration.all_pagination_size = 200
    end
  end

  describe '.sort' do
    before(:each) do
      %w[MLC-St-Ives MLC-Penzance MLC-Truro].each do |store_code|
        create_pickup_option(store_code, name: "My little Cornershop - #{store_code}")
      end
      allow(client).to receive(:put_uri_list).and_call_original
    end

    # The API expects the pickup options of the whole page, so the order sent is
    # a rotation of the shop's current order rather than of the created ones.
    def rotated_ids
      ids = listed_pickup_options.map { |pickup_option| pickup_option[:id] }
      ids.rotate
    end

    def expect_sorted_uri_list(order)
      expect(client).to have_received(:put_uri_list).with(
        'pickup-options',
        order.map { |pickup_option_id| "#{ENV.fetch('API_URL', nil)}/pickup-options/#{pickup_option_id}" }
      )
    end

    it 'reorders the pickup options of the shop' do
      desired_order = rotated_ids

      response = client.sort(desired_order)

      expect(response).to eq({})
      expect_sorted_uri_list(desired_order)
      expect(listed_pickup_options.map { |pickup_option| pickup_option[:id] }).to eq(desired_order)
    end

    it 'ignores nil pickup option ids' do
      desired_order = rotated_ids

      client.sort(desired_order.flat_map { |pickup_option_id| [pickup_option_id, nil] })

      expect_sorted_uri_list(desired_order)
      expect(listed_pickup_options.map { |pickup_option| pickup_option[:id] }).to eq(desired_order)
    end
  end

  context 'with pickup option' do
    before(:each) do
      @pickup_option = create_pickup_option('MLC-St-Ives')
    end

    describe '.create' do
      it 'creates a new pickup option' do
        expect(@pickup_option).not_to be nil
        expect(@pickup_option[:id]).to be_present
        expect(@pickup_option[:name]).to eq('My little Cornershop - St.Ives')
        expect(@pickup_option[:tax_class]).to eq('REGULAR')
        expect(@pickup_option[:phone_number_required]).to be true
        expect(@pickup_option[:free_pickup_value]).to eq(currency: 'EUR', amount: 50)
        expect(@pickup_option[:fixed_price]).to eq(tax_model: 'GROSS', currency: 'EUR', amount: 1)
        expect(@pickup_option.dig(:embedded, :location, :id)).to eq(@locations.first[:id])
      end

      it 'raises an error when the pickup option is invalid' do
        expect do
          client.create(build(:pickup_option_data, :without_name, location_id: @locations.first[:id]))
        end.to raise_error(BeyondApi::Error)
      end

      it 'raises an error when the location does not exist' do
        expect do
          client.create(build(:pickup_option_data, location_id: '00000000-0000-0000-0000-000000000000'))
        end.to raise_error(BeyondApi::Error)
      end
    end

    describe '.find' do
      it 'returns a pickup option' do
        response = client.find(@pickup_option[:id])

        expect(response[:id]).to eq(@pickup_option[:id])
        expect(response[:name]).to eq('My little Cornershop - St.Ives')
        expect(response.dig(:embedded, :location, :store_code)).to eq('MLC-St-Ives')
      end

      it 'raises an error when the pickup option does not exist' do
        expect do
          client.find('00000000-0000-0000-0000-000000000000')
        end.to raise_error(BeyondApi::Error)
      end
    end

    describe '.update' do
      it 'updates a pickup option' do
        response = client.update(@pickup_option[:id],
                                 build(:pickup_option_data, :alternative_name,
                                       location_id: @locations.first[:id]))

        expect(response).not_to be nil
        expect(response[:id]).to eq(@pickup_option[:id])
        expect(response[:name]).to eq('Updated Cornershop')
        expect(response[:tax_class]).to eq('REGULAR')
      end
    end

    describe '.delete' do
      it 'deletes a pickup option' do
        # The shop must keep at least one pickup option as long as it has no
        # shipping methods, so a second one takes over that role here.
        create_pickup_option('MLC-Penzance', name: 'My little Cornershop - MLC-Penzance')

        response = client.delete(@pickup_option[:id])

        expect(response).to eq({})
        expect { client.find(@pickup_option[:id]) }.to raise_error(BeyondApi::Error)
      end
    end
  end
end
