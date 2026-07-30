# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Product, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all products' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :products)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with product' do
    before(:each) do
      @product = client.create(build(:product_data))
    end

    describe '.create' do
      it 'creates a new product' do
        expect(@product).not_to be nil
        expect(@product[:name]).to eq('Team42 Product')
        expect(@product[:essential_features]).to eq('Dry. 12% alcohol. Best vine variety.')
        expect(@product[:tags]).to eq(['Bestseller', 'Red Wine', 'Sale'])
        expect(@product[:product_identifiers]).to eq([{ type: 'EAN', value: '9780134308135' }])
      end
    end

    describe '.find' do
      it 'returns a product' do
        response = client.find(@product[:id])
        expect(response[:name]).to eq('Team42 Product')
      end
    end

    describe '.update_product' do
      it 'updates the product' do
        update_data = { name: 'Updated Team42 Product' }
        response = client.update_product(@product[:id], update_data)

        expect(response).not_to be nil
        expect(response[:name]).to eq('Updated Team42 Product')
      end
    end

    describe '.delete_product' do
      it 'deletes the product' do
        response = client.delete_product(@product[:id])
        expect(response).to eq({})
      end
    end

    after(:each) do
      client.delete_product(@product[:id])
    rescue StandardError
      BeyondApi::Error
      # Cleanup after each test
    end
  end

  describe '.update_products_visibility' do
    it 'updates visibility for multiple products' do
      products = [client.create(build(:product_data)), client.create(build(:product_data))]
      ids = products.map { |p| p[:id] }

      response = client.update_products_visibility(ids, false)

      expect(response).not_to be nil
      expect(response.dig(:details, :visible)).to be nil
    ensure
      # Cleanup in case of test failure
      products.each do |p|
        client.delete_product(p[:id])
              rescue StandardError
                BeyondApi::Error
      end
    end
  end

  describe '.delete_multiple_products' do
    it 'deletes multiple products' do
      products = [client.create(build(:product_data)), client.create(build(:product_data))]
      ids = products.map { |p| p[:id] }

      response = client.delete_multiple_products(ids)

      expect(response).to eq({})
    ensure
      # Cleanup in case of test failure
      products.each do |p|
        client.delete_product(p[:id])
              rescue StandardError
                BeyondApi::Error
      end
    end
  end

  describe '.add_tags_to_products' do
    it 'adds tags to multiple products' do
      products = [client.create(build(:product_data)), client.create(build(:product_data))]
      ids = products.map { |p| p[:id] }
      tags = ['New Tag', 'Seasonal']

      response = client.add_tags_to_products(ids, tags)

      expect(response).not_to be nil
      expect(response).to eq({})
    ensure
      products.each do |p|
        client.delete_product(p[:id])
      rescue StandardError
        BeyondApi::Error
      end
    end
  end

  describe '.remove_tags_from_products' do
    it 'removes tags from multiple products' do
      products = [client.create(build(:product_data)), client.create(build(:product_data))]
      ids = products.map { |p| p[:id] }
      tags = ['New Tag', 'Seasonal']

      client.add_tags_to_products(ids, tags)
      response = client.remove_tags_from_products(ids, tags)

      expect(response).not_to be nil
    ensure
      products.each do |p|
        client.delete_product(p[:id])
      rescue StandardError
        BeyondApi::Error
      end
    end
  end

  context 'with variation product' do
    before(:each) do
      @variation_product = client.create_variation(build(:variation_product_data))
    end

    describe '.create_variation' do
      it 'creates a variation product' do
        expect(@variation_product).not_to be nil
        expect(@variation_product[:id]).not_to be nil
        expect(@variation_product[:name]).to eq('Team42 Variation Product')
        expect(@variation_product[:variation_attributes].map { |attribute| attribute[:display_name] })
          .to eq(%w[size color])
        expect(@variation_product[:variation_attributes].map { |attribute| attribute[:values] })
          .to eq([%w[S M], %w[Black White]])
      end
    end

    describe '.find_variation' do
      it 'returns the details of a variation product' do
        response = client.find_variation(@variation_product[:id])

        expect(response[:id]).to eq(@variation_product[:id])
        expect(response[:name]).to eq('Team42 Variation Product')
        expect(response[:variation_attributes]).to be_kind_of(Array)
      end
    end

    describe '.update_variation_product' do
      it 'updates the variation product' do
        response = client.update_variation_product(
          @variation_product[:id], { name: 'Updated Team42 Variation Product' }
        )

        expect(response).not_to be nil
        expect(response[:name]).to eq('Updated Team42 Variation Product')
      end
    end

    describe '.variation_properties' do
      it 'returns the variation properties of a product' do
        response = client.variation_properties(@variation_product[:id])

        properties = response.dig(:embedded, :variation_properties)

        expect(properties).to be_kind_of(Array)
        expect(properties.map { |property| property[:property] }).to include('sku', 'salesPrice', 'defaultImage')
        expect(properties.find { |property| property[:property] == 'salesPrice' }[:enabled]).to be false
      end
    end

    describe '.update_variation_properties' do
      it 'enables a variation property' do
        response = client.update_variation_properties(@variation_product[:id],
                                                      [{ property: 'salesPrice', enabled: true }])

        properties = response.dig(:embedded, :variation_properties)

        expect(properties.find { |property| property[:property] == 'salesPrice' }[:enabled]).to be true
      end

      it 'leaves the other variation properties untouched' do
        response = client.update_variation_properties(@variation_product[:id],
                                                      [{ property: 'defaultImage', enabled: true }])

        properties = response.dig(:embedded, :variation_properties)

        expect(properties.find { |property| property[:property] == 'defaultImage' }[:enabled]).to be true
        expect(properties.find { |property| property[:property] == 'listPrice' }[:enabled]).to be false
      end
    end

    after(:each) do
      client.delete_product(@variation_product[:id])
    rescue StandardError
      BeyondApi::Error
      # Cleanup after each test
    end
  end
end
