# frozen_string_literal: true

RSpec.describe BeyondApi::ProductManagement::Category, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all categories' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :categories)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with category' do
    before(:each) do
      @category = client.create(build(:category_data))
    end

    describe '.create' do
      it 'creates a new category' do
        expect(@category).not_to be nil
        expect(@category[:name]).to eq('Team42 Category')
        expect(@category[:type]).to eq('SMART')
        expect(@category[:default_sort]).to eq('HIGHEST_PRICE_FIRST')
      end
    end

    describe '.find' do
      it 'returns a category' do
        response = client.find(@category[:id])
        expect(response[:name]).to eq('Team42 Category')
      end
    end

    describe '.update' do
      it 'updates an existing category' do
        updated_category_data = FactoryBot.build(:category_data, :lowest_price_first)

        updated_category = client.update(@category[:id], updated_category_data)
        expect(updated_category).not_to be nil
        expect(updated_category[:name]).to eq('Category with lowest price first')
        expect(updated_category[:default_sort]).to eq('LOWEST_PRICE_FIRST')
      end
    end

    describe '.delete' do
      it 'deletes a category' do
        response = client.delete(@category[:id])
        expect(response).to eq({})
      end
    end

    after(:each) do
      client.delete(@category[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
