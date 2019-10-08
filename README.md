# Beyond API Ruby Client

![Gem Version](https://img.shields.io/gem/v/beyond_api?label=gem%20version)
[![Maintainability](https://api.codeclimate.com/v1/badges/1d173fa0b393e8eaf2a2/maintainability)](https://codeclimate.com/github/ePages-de/beyond_api-ruby_client/maintainability)
![Downloads](https://img.shields.io/gem/dt/beyond_api)
![License](https://img.shields.io/github/license/ePages-de/beyond_api-ruby_client)

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
