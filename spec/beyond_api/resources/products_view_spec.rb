RSpec.describe 'BeyondApi::ProductsView' do
  let!(:session) do
    session = BeyondApi::Session.new(api_url: ENV["API_URL"])
    session.token.client_credentials
  end

  let(:product) { @product = session.products.create(FactoryBot.build(:product)) }

  it "list products with specific tag" do
    response = session.products_view.search_by_tag("beyond_api-ruby_client")
    expect(response).not_to be nil
    expect(response.embedded.products.class).to be(Array)
    expect(response.embedded.products.size).to be >= 1
  end
end
