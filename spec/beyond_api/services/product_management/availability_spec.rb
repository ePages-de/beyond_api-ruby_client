# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Availability, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }
  let(:variation_client) do
    BeyondApi::ProductManagement::Variation.new(api_url: ENV.fetch('API_URL', nil),
                                                access_token: beyond_access_token)
  end

  before do
    @product_client = BeyondApi::ProductManagement::Product.new(api_url: ENV.fetch('API_URL', nil),
                                                                access_token: beyond_access_token)
    @product = @product_client.create(build(:product_data))
  end

  describe '.availability' do
    it 'returns the availability of a product' do
      response = client.availability(@product[:id])

      expect(response).not_to be nil
      expect(response).to include(
        :availability_state,
        :available_stock,
        :stock_threshold,
        :purchasable,
        :links
      )
    end
  end

  describe '.enable_purchasability' do
    it 'enables purchasability for a product' do
      response = client.enable_purchasability(@product[:id])

      expect(response).not_to be nil
    end
  end

  describe '.disable_purchasability' do
    it 'disables purchasability for a product' do
      response = client.disable_purchasability(@product[:id])

      expect(response).not_to be nil
    end
  end

  context 'with stock management' do
    before do
      @availability = client.enable_stock_management(@product[:id], 100, 2)
    end

    describe '.enable_stock_management' do
      it 'enables stock management for a product' do
        expect(@availability).not_to be nil
        expect(@availability[:available_stock]).to eq(100)
        expect(@availability[:stock_threshold]).to eq(2)
      end
    end

    describe '.disable_stock_management' do
      it 'disables stock management for a product' do
        response = client.disable_stock_management(@product[:id])

        expect(response).not_to be nil
        expect(response[:available_stock]).to eq(nil)
        expect(response[:stock_threshold]).to eq(nil)
      end
    end

    describe '.adjust_stock_level' do
      it 'adjusts the available stock of a product' do
        response = client.adjust_stock_level(@product[:id], 10)

        expect(response).not_to be nil
        expect(response[:available_stock]).to eq(110)
      end
    end

    describe '.update_reserve_stock' do
      it 'updates the reserve stock of a product' do
        response = client.update_reserve_stock(@product[:id], 3)

        expect(response).not_to be nil
        expect(response[:stock_threshold]).to eq(3)
      end
    end
  end

  context 'with variation product' do
    # Stock is managed per variation, so enabling it on the product gives each
    # variation its own available stock.
    before do
      @variation_product = @product_client.create_variation(build(:variation_product_data, :single_attribute))
      @variation_id = variation_client.all(@variation_product[:id]).dig(:embedded, :variations).first[:id]
      client.enable_stock_management(@variation_product[:id], 100, 2)
    end

    describe '.variation_availability' do
      it 'returns the availability of a variation' do
        response = client.variation_availability(@variation_product[:id], @variation_id)

        expect(response).not_to be nil
        expect(response).to include(
          :availability_state,
          :available_stock,
          :stock_threshold,
          :purchasable,
          :links
        )
        expect(response[:available_stock]).to eq(100)
        expect(response[:stock_threshold]).to eq(2)
      end
    end

    describe '.adjust_variation_stock_level' do
      it 'adjusts the available stock of a variation' do
        response = client.adjust_variation_stock_level(@variation_product[:id], @variation_id, -1)

        expect(response).not_to be nil
        expect(response[:available_stock]).to eq(99)
      end
    end

    after do
      @product_client.delete_product(@variation_product[:id])
    rescue StandardError
      BeyondApi::Error
      # Cleanup after each test
    end
  end

  after do
    @product_client.delete_product(@product[:id])
  end
end
