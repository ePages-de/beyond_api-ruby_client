# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Search, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.find' do
    it 'returns the products matching a search term' do
      response = client.find({ search: { term: 'Team42', category: 'ALL' },
                               paging: { page: 0, page_size: 5 } })

      expect(response).not_to be nil
      expect(response.dig(:embedded, :products)).to be_kind_of(Array)
      expect(response[:page]).to include(:size, :total_elements, :total_pages, :number)
    end

    it 'honours the requested page size' do
      response = client.find({ search: { term: 'Team42', category: 'ALL' },
                               paging: { page: 0, page_size: 2 } })

      expect(response.dig(:page, :size)).to eq(2)
      expect(response.dig(:page, :number)).to eq(0)
      expect(response.dig(:embedded, :products).size).to be <= 2
    end

    it 'applies the given filters' do
      response = client.find({ search: { term: 'Team42', category: 'ALL' },
                               filters: [{ key: 'status', values: ['DRAFT'] }],
                               paging: { page: 0, page_size: 5 } })

      expect(response).not_to be nil
      expect(response.dig(:embedded, :products)).to be_kind_of(Array)
      expect(response.dig(:page, :total_elements)).to be_kind_of(Integer)
    end

    it 'searches within a single category' do
      response = client.find({ search: { term: 'Team42', category: 'NAME' },
                               paging: { page: 0, page_size: 5 } })

      expect(response.dig(:embedded, :products)).to be_kind_of(Array)
    end

    it 'returns an empty result set when nothing matches' do
      response = client.find({ search: { term: 'no-product-matches-this-term', category: 'ALL' },
                               paging: { page: 0, page_size: 5 } })

      expect(response.dig(:page, :total_elements)).to eq(0)
      expect(response.dig(:embedded, :products)).to eq([])
    end

    it 'raises an error when the search category is missing' do
      expect { client.find({ search: { term: 'Team42' }, paging: { page: 0, page_size: 5 } }) }
        .to raise_error(BeyondApi::Error, /Input validation failed/)
    end
  end
end
