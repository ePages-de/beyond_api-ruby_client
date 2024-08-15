RSpec.describe 'BeyondApi::Authentication::Token', vcr: true do
  let(:client) do
    BeyondApi::Authentication::Token.new(
      api_url: ENV["API_URL"],
      client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"]
    )
  end

  it "retrieves token via client credentials" do
    response = client.client_credentials
    expect(response).not_to be nil
    expect(response[:access_token].class).to be(String)
    expect(response[:refresh_token]).to be(nil)
  end

  it "retrieves token via authorization code" do
    expect {
      response = client.get('abcde')
    }.to raise_error(BeyondApi::Error) do |error|
      expect(error.response[:error]).to eq("invalid_grant")
      expect(error.response[:error_description]).to eq("Invalid authorization code: abcde")
    end
  end

  it "refreshes the token" do
    response = client.refresh(ENV["REFRESH_TOKEN"])
    expect(response).not_to be nil
    expect(response[:access_token].class).to be(String)
    expect(response[:refresh_token].class).to be(String)
  end
end
