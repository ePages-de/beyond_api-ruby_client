# frozen_string_literal: true

RSpec.describe BeyondApi::Customer, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  describe '.all' do
    it 'returns all customers' do
      response = client.all

      expect(response).not_to be nil
      expect(response.dig(:embedded, :customers)).to be_kind_of(Array)
      expect(response[:page]).to be_kind_of(Hash)
    end
  end

  context 'with customer' do
    before(:each) do
      @customer = client.create(build(:customer_data))
    end

    describe '.create' do
      it 'creates a new customer' do
        expect(@customer).not_to be nil
        expect(@customer.dig(:default_billing_address, :company)).to eq('ePages GmbH')
        expect(@customer.dig(:default_billing_address, :first_name)).to eq('Chayanne')
        expect(@customer.dig(:default_billing_address, :last_name)).to eq('Team42')
        expect(@customer.dig(:default_billing_address, :street)).to eq('Pilatuspool')
        expect(@customer.dig(:default_billing_address, :house_number)).to eq('2')
        expect(@customer.dig(:default_billing_address, :postal_code)).to eq('20999')
        expect(@customer.dig(:default_billing_address, :city)).to eq('Alsterwasser')
        expect(@customer.dig(:default_billing_address, :country)).to eq('DE')
        expect(@customer.dig(:default_billing_address, :state)).to eq('Hamburg')
        expect(@customer.dig(:default_billing_address, :email)).to eq('chayanne@example.com')
        expect(@customer.dig(:default_billing_address, :phone)).to eq('(800) 555-0102')
      end
    end

    describe '.find' do
      it 'returns a customer' do
        response = client.find(@customer[:id])
        expect(response.dig(:default_billing_address, :first_name)).to eq('Chayanne')
      end
    end

    describe '.update' do
      it 'updates an existing customer' do
        updated_customer_data = FactoryBot.build(:customer_data, :berlin_shipping)

        updated_customer = client.update(@customer[:id], updated_customer_data)
        expect(updated_customer).not_to be nil
        expect(updated_customer.dig(:default_shipping_address, :company)).to eq('Updated GmbH')
      end
    end

    describe '.events' do
      it 'returns all events for a customer' do
        response = client.events(@customer[:id])
        expect(response).not_to be nil
        expect(response.dig(:embedded, :customer_events)).to be_kind_of(Array)
      end
    end

    describe '.delete' do
      it 'deletes a customer' do
        response = client.delete(@customer[:id])
        expect(response).to eq({})
      end
    end

    after(:each) do
      client.delete(@customer[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
