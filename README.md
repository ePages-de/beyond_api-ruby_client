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
# Initializing the client
client = BeyondApi::Token.new(api_url: 'https://team42.beyondshop.cloud/api', client_id: '<YOUR_CLIENT_ID>', client_secret: '<YOUR_CLIENT_SECRET>')
```
## Generate a token from [client credentials](https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_client_credentials)

```ruby
client = client.client_credentials

# => {:access_token=> "<YOUR_ACCESS_TOKEN>", :token_type=>"bearer", :expires_in=>3599, :scope=> "orde:r prat:dcur pypr:cur prod:urdc", :tenant_id=>1147, :iat=>1723477546,  :jti=>"mqXCnX/q/vStoJO69q68x1gw61c="}
```

## Generate a token from [authorization code](https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_authorization_code)

```ruby
client = client.get('1nBfq_')

# => {:access_token=>  "<YOUR_ACCESS_TOKEN>", :token_type=>"bearer", :refresh_token=> "<YOUR_REFRESH_TOKEN>", :expires_in=>3599, :scope=> "orde:r prat:dcur pypr:cur prod:urdc", :tenant_id=>1147, :iat=>1723453179, :jti=>"C0N0VYQUgzchp2GGo8WaINhpM8s="}
```

## Generate a token from [refresh token](https://developer.epages.com/beyond-docs/#create_a_jsonwebtoken_from_refresh_token)

```ruby
client = client.refresh_token('<YOUR_REFRESH_TOKEN>')

# => {:access_token=>  "<YOUR_ACCESS_TOKEN>", :token_type=>"bearer", :refresh_token=> "<YOUR_REFRESH_TOKEN>", :expires_in=>3599, :scope=> "orde:r prat:dcur pypr:cur prod:urdc lcnt:u pymt:ur loca:urcd sctg:m shat:cdru rfpr:ur prad:rcd", :tenant_id=>1147, :iat=>1723453179, :jti=>"C0N0VYQUgzchp2GGo8WaINhpM8s="}
```

## Making requests

After generating your token following the instructions above, you can start using this gem to access various resources available, including categories, products, orders, webhooks, and more.

```ruby
client = BeyondApi::ProductManagement::Category.new(api_url: ENV["API_URL"], access_token: '<YOUR_ACCESS_TOKEN>')

# Retrieve all categories
client.all

# =>  {:embedded=>{:categories=>[{:id=>"539c1671-1540-4254-adaf-8b22b188d6d2", :name=>"New Category", :type=>"SMART", :default_sort=>"HIGHEST_PRICE_FIRST", :filters=>[], :links=>  {:self=>{:href=>"https://team42.beyondshop.cloud/api/categories/539c1671-1540-4254-adaf-8b22b188d6d2"}, :category=>{:href=>"https://team42.beyondshop.cloud/api/categories/539c1671-1540-4254-adaf-8b22b188d6d2"}}}]}, :links=>{:self=>{:href=>"https://team42.beyondshop.cloud/api/categories?page=0&size=20"}}, :page=>{:size=>20, :total_elements=>9, :total_pages=>1, :number=>0}}
```

## Documentation

See [GETTING_STARTED](https://github.com/ePages-de/beyond_api-ruby_client/blob/master/GETTING_STARTED.md) for information on consuming the Beyond API.

## Development

Check out the repo an run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

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
