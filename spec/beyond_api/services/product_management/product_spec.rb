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
end
