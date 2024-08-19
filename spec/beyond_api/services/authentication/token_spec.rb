RSpec.describe BeyondApi::Authentication::Token, vcr: true do
  it "retrieves token via client credentials" do
    response = auth_client.client_credentials
    expect(response).not_to be nil
    expect(response[:access_token].class).to be(String)
    expect(response[:refresh_token]).to be(nil)
  end

  it "retrieves token via authorization code" do
    expect {
      response = auth_client.get('abcde')
    }.to raise_error(BeyondApi::Error) do |error|
      expect(error.response[:error]).to eq("invalid_grant")
      expect(error.response[:error_description]).to eq("Invalid authorization code: abcde")
    end
  end

  it "refreshes the token" do
    response = auth_client.refresh(ENV["REFRESH_TOKEN"])
    expect(response).not_to be nil
    expect(response[:access_token].class).to be(String)
    expect(response[:refresh_token].class).to be(String)
  end
end
