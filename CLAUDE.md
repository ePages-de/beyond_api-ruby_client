# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
bin/setup

# Run all tests
bundle exec rspec

# Run a single spec file
bundle exec rspec spec/beyond_api/services/product_management/product_spec.rb

# Run a single example
bundle exec rspec spec/beyond_api/services/product_management/product_spec.rb -e "returns all products"

# Lint
bundle exec rubocop

# Auto-fix lint issues
bundle exec rubocop -a

# Generate docs
bundle exec rake yard

# Interactive console (uses .env.development)
bin/console

# Install gem locally
bundle exec rake install
```

## Environment Setup

Copy `.env.test.template` to `.env.test` and fill in credentials before running tests. Copy `.env.development.template` to `.env.development` for the console.

Required env vars: `API_URL`, `CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN`.

## Architecture

This is a Ruby gem wrapping the [ePages Beyond API](https://developer.epages.com/beyond-docs/). It uses **Faraday** for HTTP and **Zeitwerk** for autoloading.

### Namespace Structure

Services live under `lib/beyond_api/services/` and are exposed as `BeyondApi::<Namespace>::<Resource>`:

- `BeyondApi::Authentication::Token` — OAuth token generation (client credentials, authorization code, refresh token)
- `BeyondApi::Authentication::Signer` — request signing
- `BeyondApi::ProductManagement::Product` — products CRUD
- `BeyondApi::ProductManagement::Category` — product categories
- `BeyondApi::ProductManagement::Image` / `VariationImage` / `Variation` — product media and variations
- `BeyondApi::ProductView::Category` — storefront product view
- `BeyondApi::Checkout::ShippingZone` / `Cart` — checkout flows
- `BeyondApi::Checkout::PickupOption` — pickup options for in-store pickup during checkout
- `BeyondApi::Shop::Shop` / `Address` — shop configuration
- `BeyondApi::Shop::Location` — shop locations (store details, opening hours, Google Business data)
- `BeyondApi::Storefront::ScriptTag` — storefront scripting
- `BeyondApi::Webhook::Subscription` — webhook management
- `BeyondApi::Customer` — customer records
- `BeyondApi::CustomerGroup` — customer groups and group membership

### Request/Response Flow

1. Each service class inherits from `BeyondApi::BaseService`.
2. `BaseService` includes `Concerns::Connection` (HTTP methods: `get`, `post`, `put`, `patch`, `delete`, `upload_file`, `upload_files`) and `Concerns::Pagination`.
3. Request bodies are **camelized** before sending via `Utils.camelize_keys`. `Authentication::Token` disables this (`@camelize_keys = false`).
4. Responses are parsed by `BeyondApi::Response`, which **snake_cases** all keys and converts them to symbols. Leading underscores are stripped (e.g., `_links` → `:links`).
5. Failed responses raise `BeyondApi::Error`; Faraday connection errors raise `BeyondApi::FaradayError`.

### Pagination

- `fetch_all_pages(url, params)` — when `params[:paginated] == false`, uses `AllPagesHandler` to automatically fetch and merge all pages; otherwise returns the single paginated response.
- `AllPagesHandler` iterates pages using `all_pagination_size` (default 200) and merges results under the embedded resource key.

### Authentication

`Authentication::Token` uses `:basic` authorization (client_id/client_secret) rather than `:bearer`. All other services use bearer token auth. The Faraday connection is lazily built and memoized in `@agent`.

### Configuration

```ruby
BeyondApi.setup do |config|
  config.client_id     = 'your_client_id'
  config.client_secret = 'your_client_secret'
  config.timeout       = 5       # seconds
  config.open_timeout  = 2       # seconds
  config.log_level     = :info
  config.log_bodies    = false
  config.log_headers   = false
  config.all_pagination_size = 200
end
```

### Testing

Tests use **RSpec** with **VCR** cassettes (`spec/vcr_cassettes/`) to record and replay HTTP interactions. VCR matches on `[:method, :uri, :body]` and filters sensitive data. **FactoryBot** factories are in `spec/factories/`. The helper `beyond_access_token` in `spec_helper.rb` fetches a live token via `client_credentials`.

To record new cassettes, run with real credentials; existing cassettes are replayed without network access.

### Code Style

RuboCop is configured in `.rubocop.yml` with `rubocop-rails`. Notable conventions:
- Symbol arrays use bracket style: `[:foo, :bar]`
- Lambda literals use `->` syntax
- Metric cops (AbcSize, MethodLength, ClassLength, BlockLength) are disabled
