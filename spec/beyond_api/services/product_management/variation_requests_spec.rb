# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Variation, :stubbed_requests do
  let(:client) { stubbed_client }
  let(:product_id) { '4125b993-49fc-47c8-b9b3-76d8871e4e06' }

  describe '.all' do
    it 'follows every page when paginated is false' do
      pages = [%w[var-1 var-2], %w[var-3]]
      requests = record_requests(body: ->(request) {
        number = request.uri.query_values['page'].to_i
        page_body(:variations, pages[number], total_pages: 2, total_elements: 3, number:)
      })

      response = client.all(product_id, paginated: false)

      expect(requests.size).to eq(2)
      expect(response.dig(:embedded, :variations).map { |variation| variation[:id] }).to eq(%w[var-1 var-2 var-3])
    end

    it 'returns a single page by default' do
      requests = record_requests(body: page_body(:variations, %w[var-1], total_pages: 2, total_elements: 3))

      client.all(product_id)

      expect(requests.size).to eq(1)
      expect(requests.first.uri.path).to eq("/api/products/#{product_id}/variations")
    end
  end
end
