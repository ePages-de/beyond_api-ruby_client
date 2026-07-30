# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Variation, vcr: true do
  let(:access_token) { beyond_access_token }
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token:) }
  let(:product_client) do
    BeyondApi::ProductManagement::Product.new(api_url: ENV.fetch('API_URL', nil), access_token:)
  end

  # A variation product with a single `size` attribute yields two variations (S, M).
  before do
    @product = product_client.create_variation(build(:variation_product_data, :single_attribute))
  end

  describe '.all' do
    it 'returns the variations of a variation product' do
      response = client.all(@product[:id])

      expect(response).not_to be nil
      expect(response.dig(:embedded, :variations)).to be_kind_of(Array)
      expect(response.dig(:embedded, :variations).size).to eq(2)
      expect(response.dig(:page, :total_elements)).to eq(2)
    end

    it 'returns the variation attribute values of each variation' do
      variations = client.all(@product[:id]).dig(:embedded, :variations)

      values = variations.flat_map { |variation| variation[:variation_attribute_values] }

      expect(values.map { |value| value[:display_name] }.uniq).to eq(['size'])
      expect(values.map { |value| value[:value] }).to contain_exactly('S', 'M')
    end

    it 'returns every variation when paginated is false' do
      response = client.all(@product[:id], paginated: false)

      expect(response.dig(:embedded, :variations).size).to eq(2)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  describe '.update' do
    let(:variation_id) { client.all(@product[:id]).dig(:embedded, :variations).first[:id] }

    it 'updates the sku of a variation' do
      response = client.update(@product[:id], variation_id, { sku: 'SKU-1010' })

      expect(response).not_to be nil
      expect(response[:sku]).to eq('SKU-1010')
      expect(response[:id]).to eq(variation_id)
    end

    it 'updates the sales price once the salesPrice variation property is enabled' do
      product_client.update_variation_properties(@product[:id], [{ property: 'salesPrice', enabled: true }])

      response = client.update(@product[:id], variation_id,
                               { sales_price: { tax_model: 'GROSS', amount: 24.99, currency: 'GBP' } })

      expect(response.dig(:sales_price, :derived_price, :amount)).to eq(24.99)
      expect(response.dig(:sales_price, :derived_price, :tax_model)).to eq('GROSS')
    end

    it 'raises an error when updating a property that is not enabled for variations' do
      expect do
        client.update(@product[:id], variation_id,
                      { list_price: { tax_model: 'GROSS', amount: 44.99, currency: 'GBP' } })
      end.to raise_error(Faraday::RetriableResponse)
    end
  end

  after do
    product_client.delete_product(@product[:id])
  rescue StandardError
    BeyondApi::Error
    # Cleanup after each test
  end
end
