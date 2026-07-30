# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Product, :stubbed_requests do
  let(:client) { stubbed_client }
  let(:product_id) { '4125b993-49fc-47c8-b9b3-76d8871e4e06' }

  describe '.variation_properties' do
    it 'GETs the variation properties resource' do
      requests = record_requests

      client.variation_properties(product_id)

      expect(requests.first.method).to eq(:get)
      expect(requests.first.uri.path).to eq("/api/products/#{product_id}/variation-properties")
    end
  end

  describe '.assign_variation_differentiator' do
    let(:variation_attribute_id) { 'a1b2c3d4-e5f6-7890-abcd-ef1234567890' }

    it 'POSTs to the make-differentiator resource' do
      requests = record_requests

      client.assign_variation_differentiator(product_id, variation_attribute_id)

      expect(requests.first.method).to eq(:post)
      expect(requests.first.uri.path).to eq(
        "/api/products/#{product_id}/variation-attributes/#{variation_attribute_id}/make-differentiator"
      )
    end
  end

  describe '.create_custom_attribute' do
    it 'POSTs the attribute body camelized' do
      requests = record_requests

      client.create_custom_attribute(product_id, { type: 'material', value: 'cotton', display_name: 'Material' })

      request = requests.first
      expect(request.method).to eq(:post)
      expect(request.uri.path).to eq("/api/products/#{product_id}/attributes")
      expect(JSON.parse(request.body)).to eq(
        'type' => 'material', 'value' => 'cotton', 'displayName' => 'Material'
      )
    end
  end
end
