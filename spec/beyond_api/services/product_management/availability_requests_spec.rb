# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Availability, :stubbed_requests do
  let(:client) { stubbed_client }
  let(:product_id) { '4125b993-49fc-47c8-b9b3-76d8871e4e06' }
  let(:variation_id) { 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' }

  describe '.variation_availability' do
    it 'GETs the variation availability resource' do
      requests = record_requests

      client.variation_availability(product_id, variation_id)

      expect(requests.first.method).to eq(:get)
      expect(requests.first.uri.path).to eq("/api/products/#{product_id}/variations/#{variation_id}/availability")
    end
  end

  describe '.adjust_variation_stock_level' do
    it 'POSTs the relative amount camelized' do
      requests = record_requests

      client.adjust_variation_stock_level(product_id, variation_id, -1)

      request = requests.first
      expect(request.method).to eq(:post)
      expect(request.uri.path).to eq(
        "/api/products/#{product_id}/variations/#{variation_id}/availability/adjust-available-stock"
      )
      expect(JSON.parse(request.body)).to eq('relativeAmount' => -1)
    end
  end
end
