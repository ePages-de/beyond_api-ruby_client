# frozen_string_literal: true

RSpec.describe BeyondApi::CustomerGroup, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all customer groups' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :customer_groups)).to be_kind_of(Array)
      expect(response[:page]).to include(:size, :total_elements, :total_pages, :number)

      customer_group = response.dig(:embedded, :customer_groups).first
      expect(customer_group[:id]).to eq('05f34f85-a270-47f0-a65f-2b0eb4fd03f2')
      expect(customer_group[:name]).to eq('PREF3')
      expect(customer_group[:discount_percentage]).to eq(-0.3)
      expect(customer_group[:customer_count]).to eq(0)
    end

    it 'honours the requested page size' do
      response = client.all(size: 2)

      expect(response.dig(:embedded, :customer_groups).size).to eq(2)
      expect(response.dig(:page, :size)).to eq(2)
      expect(response.dig(:page, :total_pages)).to eq(2)
    end

    it 'follows every page when paginated is false' do
      # A page size of two spreads the four customer groups over two pages.
      BeyondApi.configuration.all_pagination_size = 2

      response = client.all(paginated: false)

      expect(response.dig(:embedded, :customer_groups).map { |group| group[:name] })
        .to eq(%w[PREF3 VIP1 PREF2 PREF1])
      expect(response.dig(:page, :total_pages)).to eq(1)
      expect(response.dig(:page, :total_elements)).to eq(4)
    ensure
      BeyondApi.configuration.all_pagination_size = 200
    end
  end

  describe '.add_customer' do
    it 'adds a customer to the given customer groups' do
      response = client.add_customer('49916446-cfbb-40c4-bfed-37030e5540d1',
                                     ['5e173c7c-b5b3-4f39-8b4c-932a1240afb6'])

      expect(response).not_to be nil

      customer_groups = response.dig(:embedded, :customer_groups)
      expect(customer_groups.map { |group| group[:id] }).to eq(['5e173c7c-b5b3-4f39-8b4c-932a1240afb6'])
      expect(customer_groups.first[:name]).to eq('Subscribers')
    end

    it 'raises an error when the customer cannot be assigned to a customer group' do
      # Only COCKPIT, IMPORT and STOREFRONT customers can join a customer group.
      expect do
        client.add_customer('a55ff2a4-eb1c-4bbf-9e6c-2ea1c5a89d02',
                            ['5e173c7c-b5b3-4f39-8b4c-932a1240afb6'])
      end.to raise_error(BeyondApi::Error, /customer-not-available-for-customer-group/)
    end
  end
end
