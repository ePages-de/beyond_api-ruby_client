# Getting started

This guide will help you quickly get started with the Beyond API Ruby Client by demonstrating how to obtain and use access tokens.

### Obtaining an Authentication Token

```ruby
require 'beyond_api'

api_url = '<YOUR_SHOP_URL>/api'

# Initialize the client for authentication
client = BeyondApi::Authentication::Token.new(api_url:)

# Replace 'your-auth-code' with the actual code you obtained
token = client.get("your-auth-code")

access_token = token[:access_token]
refresh_token = token[:refresh_token]
```

> You can get an authentication code by clicking the **Test authorization** button in your test shop's cockpit on your custom app's page.
Clicking the button will redirect you to the **Application Callback URL** you have specified, attaching the code as a query parameter.

### Refreshing an Access Token

```ruby
# Initialize the client for authentication
client = BeyondApi::Authentication::Token.new(api_url: api_url)

# Use the refresh token to get a new access token
new_token = client.refresh(refresh_token)

new_access_token = new_token[:access_token]
new_refresh_token = new_token[:refresh_token]
```

## Consuming the API

Check the [_rubydoc_ documentation](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client) for more information on the Beyond API Ruby Client.

- BeyondApi::Authentication::Signer
- BeyondApi::Authentication::Token
- BeyondApi::Checkout::ShippingZone
- BeyondApi::ProductManagement::Category
- BeyondApi::ProductManagement::Image
- BeyondApi::ProductManagement::Product
- BeyondApi::ProductManagement::VariationImage
- BeyondApi::ProductManagement::Variation
- BeyondApi::ProductView::Category
- BeyondApi::Shop::Address
- BeyondApi::Shop::Shop
- BeyondApi::Storefront::ScriptTag
- BeyondApi::Webhook::Subscription
