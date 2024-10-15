# Beyond API Ruby Client

Ruby toolkit for the [ePages API](https://developer.epages.com/beyond-docs/#introduction)

![Gem Version](https://img.shields.io/gem/v/beyond_api?label=gem%20version)
[![Docs](https://img.shields.io/badge/docs-rubydoc-blue)](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client)
[![Maintainability](https://api.codeclimate.com/v1/badges/1d173fa0b393e8eaf2a2/maintainability)](https://codeclimate.com/github/ePages-de/beyond_api-ruby_client/maintainability)
![License](https://img.shields.io/github/license/ePages-de/beyond_api-ruby_client)

## Get your credentials

### Sign up for a developer test shop

First you will need to sign up for a Beyond test shop.
Visit [our sign up form](https://signup.beyondshop.cloud), fill out the form with your data, and click the **Sign up** button.

### Create a custom app

Log in to the cockpit of your test shop, navigate to **Apps > Custom apps** and click **Add custom app**.
Fill out the form with the **App name**, **Application Callback URL** and **App scopes**.
Save your app.

You will then receive your `client_id` and `client_secret` that you will use in the next step.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "beyond_api"
```

And then execute:

```bash
$ bundle install
```

Next, you need to run the generator:

```bash
$ rails generate beyond_api:install
```

This will generate the configuration file on `config/initializers/beyond_api.rb`. Set the `client_id` and `client_secret` values to get started.

> ⚠️ **Be careful!** Don't expose your `client_id` and `client_secret` or publish them on GitHub or any other service. Use [Rails Credentials](https://guides.rubyonrails.org/security.html#custom-credentials) or a gem like [dotenv](https://github.com/bkeepers/dotenv) to save your environment variables.

To install the gem manually from your shell, run:

```bash
$ gem install beyond_api
```

## Generating tokens

API methods can be accessed through the client instance methods. This gem supports the various authentication methods supported by the ePages API.

```ruby
# Client for authentication
api_url = '<YOUR_SHOP_URL>/api'
client = BeyondApi::Authentication::Token.new(api_url:)
```
## Generate a token from [client credentials](https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_client_credentials)

```ruby
client = client.client_credentials

# => {:access_token=> "<YOUR_ACCESS_TOKEN>", :token_type=>"bearer", :expires_in=>3599, :scope=> "orde:r prat:dcur pypr:cur prod:urdc", :tenant_id=>1147, :iat=>1723477546,  :jti=>"mqXCnX/q/vStoJO69q68x1gw61c="}
```

## Generate a token from [authorization code](https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_authorization_code)

```ruby
client = client.get('<YOUR_AUTH_CODE>')

# => {:access_token=>  "<YOUR_ACCESS_TOKEN>", :token_type=>"bearer", :refresh_token=> "<YOUR_REFRESH_TOKEN>", :expires_in=>3599, :scope=> "orde:r prat:dcur pypr:cur prod:urdc", :tenant_id=>1147, :iat=>1723453179, :jti=>"C0N0VYQUgzchp2GGo8WaINhpM8s="}
```

## Generate a token from [refresh token](https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_refresh_token)

```ruby
# Client for authentication
api_url = '<YOUR_SHOP_URL>/api'
refresh_token = '<YOUR_REFRESH_TOKEN>'
client = BeyondApi::Authentication::Token.new(api_url:)

client.refresh(refresh_token)

# => {:access_token=>  "<NEW_ACCESS_TOKEN>", :token_type=>"bearer", :refresh_token=> "<NEW_REFRESH_TOKEN>", :expires_in=>3599, :scope=> "orde:r prat:dcur pypr:cur prod:urdc lcnt:u pymt:ur loca:urcd sctg:m shat:cdru rfpr:ur prad:rcd", :tenant_id=>1147, :iat=>1723453179, :jti=>"C0N0VYQUgzchp2GGo8WaINhpM8s="}
```

## Making requests

After generating your token following the instructions above, you can start using this gem to access various resources available, including categories, products, orders, webhooks, and more.

```ruby
# Define the API URL and access token
api_url = '<YOUR_SHOP_URL>/api'
access_token = '<YOUR_ACCESS_TOKEN>'

# Create a new client instance for category management
client = BeyondApi::ProductManagement::Category.new(api_url:, access_token:)

# Find a specific category by its ID
client.find('category-id')

# The response is a hash representing the category details:
# => {
#      :id=>"8a4a8f6a-e3d9-4616-9e89-12c42c084534",
#      :name=>"DO-NOT-DELETE Category",
#      :type=>"SMART",
#      :default_sort=>"HIGHEST_PRICE_FIRST",
#      :filters=>[],
#      :links=>{
#        :self=>{
#          :href=>"https://team42-beyond-api.beyondshop.cloud/api/categories/8a4a8f6a-e3d9-4616-9e89-12c42c084534"
#        },
#        :category=>{
#          :href=>"https://team42-beyond-api.beyondshop.cloud/api/categories/8a4a8f6a-e3d9-4616-9e89-12c42c084534"
#        }
#      }
#    }

```

## Documentation

See [GETTING_STARTED](https://github.com/ePages-de/beyond_api-ruby_client/blob/master/GETTING_STARTED.md) for information on consuming the Beyond API.

## Development

Check out the repo an run `bin/setup` to install dependencies. Rename the file `.env.development.template` to `.env.development` and fill in the necessary information. Then, you can run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Test

Rename the file `.env.test.template` to `.env.test` and fill in the necessary information. Then, run `rspec` to run the tests.

## Contributing

Please see [CONTRIBUTING](https://github.com/ePages-de/beyond_api-ruby_client/blob/master/CONTRIBUTING.md).

## Changelog

Beyond API's changelog is available [here](https://github.com/ePages-de/beyond_api-ruby_client/blob/master/CHANGELOG.md).

## License

beyond_api is Copyright © 2019 ePages GmbH. It is free software, and may be redistributed under the terms specified in the [LICENSE](https://github.com/ePages-de/beyond_api-ruby_client/blob/master/LICENSE) file.

## About ePages

As the largest independent provider of online shop software in Europe, ePages specialises in high-performance ecommerce solutions for small and medium-sized businesses.
Today, 100,000 companies in 70 countries operate professional online shops with ePages software in the cloud.

And we love open source software!
Check out our [other projects](https://github.com/ePages-de), or [become part of our team](https://developer.epages.com/devjobs/) and develop great ecommerce software with us!
