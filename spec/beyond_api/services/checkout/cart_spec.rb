# frozen_string_literal: true

RSpec.describe BeyondApi::Checkout::Cart, vcr: true do
  let(:client) { described_class.new(api_url: ENV.fetch('API_URL', nil), access_token: beyond_access_token) }

  context 'with cart' do
    before(:each) do
      @cart = client.create
    end

    describe '.create' do
      it 'creates a new cart' do
        expect(@cart).not_to be nil
        expect(@cart[:id]).to be_kind_of(String)
      end
    end

    describe '.find' do
      it 'retrieves the details of a cart' do
        cart_details = client.find(@cart[:id])
        expect(cart_details).not_to be nil
        expect(cart_details[:id]).to eq(@cart[:id])
      end
    end

    describe '.billing_address' do
      it 'sets the billing address of the cart' do
        body = {
          salutation: 'Mrs',
          gender: 'FEMALE',
          title: 'Dr',
          first_name: 'Astrid',
          middle_name: 'Agnes',
          last_name: 'Alster',
          street: 'Alsterwasserweg',
          house_number: '2',
          street2: 'Erdgeschoss',
          door_code: '0185',
          address_extension: 'Hinterhof',
          postal_code: '20999',
          dependent_locality: 'Seevetal',
          city: 'Alsterwasser',
          country: 'DE',
          state: 'Hamburg',
          email: 'a.alsterh@example.com',
          phone: '(800) 555-0102',
          mobile: '(800) 555-0103',
          vat_id: '123456789',
          tax_number: '123-34-6789',
          birth_date: '1985-03-20'
        }
        billing_address = client.billing_address(@cart[:id], body)
        expect(billing_address).not_to be nil
        expect(billing_address[:billing_address][:first_name]).to eq(body[:first_name])
      end
    end

    describe '.shipping_address' do
      it 'sets the shipping address of the cart' do
        body = {
          salutation: 'Mrs',
          gender: 'FEMALE',
          title: 'Dr',
          first_name: 'Astrid',
          middle_name: 'Agnes',
          last_name: 'Alster',
          street: 'Alsterwasserweg',
          house_number: '2',
          street2: 'Erdgeschoss',
          door_code: '0185',
          address_extension: 'Hinterhof',
          postal_code: '20999',
          dependent_locality: 'Seevetal',
          city: 'Alsterwasser',
          country: 'DE',
          state: 'Hamburg',
          email: 'a.alsterh@example.com',
          phone: '(800) 555-0102',
          mobile: '(800) 555-0103',
          vat_id: '123456789',
          tax_number: '123-34-6789',
          birth_date: '1985-03-20'
        }
        shipping_address = client.shipping_address(@cart[:id], body)
        expect(shipping_address).not_to be nil
        expect(shipping_address[:shipping_address][:first_name]).to eq(body[:first_name])
      end
    end

    describe '.payment_methods' do
      it 'lists all applicable payment methods for the current cart' do
        response = client.payment_methods(@cart[:id])
        expect(response).not_to be nil
        expect(response.dig(:embedded, :payment_methods)).to be_an(Array)
      end
    end

    describe '.assign_payment_method_to_default' do
      it 'sets the cart payment method to the current default payment method' do
        response = client.assign_payment_method_to_default(@cart[:id])
        expect(response).not_to be nil
      end
    end

    describe '.create_payment' do
      it 'initiates the creation of a payment' do
        body = {
          return_uri: 'https://example.com/return',
          cancel_uri: 'https://example.com/cancel'
        }
        # There is no payment method definition associated with this payment method
        expect { client.create_payment(@cart[:id], body) }.to raise_error(BeyondApi::Error)
      end
    end

    describe '.create_payment_and_order' do
      it 'initiates the creation of a payment and order for the cart' do
        body = {
          return_uri: 'https://example.com/return',
          cancel_uri: 'https://example.com/cancel',
          customer_comment: 'Please send with UPS.',
          sales_channel: 'Storefront',
          marketing_channel: 'Google Shopping',
          marketing_subchannel: 'Summer Sale',
          test_order: false,
          terms_and_conditions_explicitly_accepted: true
        }
        # There is no payment method definition associated with this payment method
        expect { client.create_payment_and_order(@cart[:id], body) }.to raise_error(BeyondApi::Error)
      end
    end

    describe '.assign_shipping_method_to_default' do
      it 'sets the cart shipping method to the current default shipping method' do
        response = client.assign_shipping_method_to_default(@cart[:id])
        expect(response).not_to be nil
      end
    end

    describe '.pickup_options' do
      it 'lists all applicable pickup options for the current cart' do
        response = client.pickup_options(@cart[:id])
        expect(response).not_to be nil
        expect(response.dig(:embedded, :pickup_options)).to be_an(Array)
      end
    end

    describe '.redeem_coupon' do
      it 'redeems a coupon' do
        coupon_code = 'FIRST-ORDER'
        # The coupon code validation failed with following messages: Code doesn't exist
        expect { client.redeem_coupon(@cart[:id], coupon_code) }.to raise_error(BeyondApi::Error)
      end
    end

    describe '.delete_coupon' do
      it 'removes a coupon from the cart' do
        coupon_code = 'FIRST-ORDER'
        # The coupon code validation failed with following messages: Code doesn't exist
        expect { client.redeem_coupon(@cart[:id], coupon_code) } .to raise_error(BeyondApi::Error)
      end
    end

    describe '.delete' do
      it 'deletes a cart' do
        response = client.delete(@cart[:id])
        expect(response).to eq({})
      end
    end

    after(:each) do
      client.delete(@cart[:id])
    rescue BeyondApi::Error # rubocop:disable Lint/SuppressedException
    end
  end
end
