RSpec.describe BeyondApi::Authentication::Signer, vcr: true do
  let(:client) { described_class.new(api_url: ENV["API_URL"], access_token: auth_client.client_credentials[:access_token]) }

  describe '#all' do
    it 'returns all signers' do
      signers = client.all

      expect(signers.dig(:embedded, :signers)).to be_an(Array)
    end
  end

  context "with signer" do
    before(:each) do
      @signer = client.create
    end

    describe '#create' do
      it 'creates a new signer' do
        expect(@signer).to be_a(Hash)
      end
    end

    describe '#delete' do
      it 'deletes a signer' do
        response = client.delete(@signer[:id])
        expect(response).to be {}
      end
    end
  end
end