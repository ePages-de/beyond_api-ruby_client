### v0.20.0.pre

* features
  * Add product search method
    * `Products#search`

### v0.19.0.pre

* features
  * Upload multiple images for products and variations

### v0.18.2.pre

* bug-fixes
  * Move `#products.update_reserve_stock` from `POST` to `PUT`.

* enhancements
  * Update how `api_url` is set on `BeyondApi::Session`.

* features
  * Install, configure and fix most of the Rubocop issues.

### v0.18.1.pre

* bug-fixes
  * Prevent logging `code` and `refresh_token` on `/api/token` calls.

### v0.18.0.pre

* features
  * Add new token retrieval/refresh methods
    * `Token#authorization_code`
    * `Token#refresh_token`
    * `Token#client_credentials`
  * Add alias methods for avoiding deprecation
    * `refresh` -> `refresh_token`
    * `create`  -> `authorization_code`

### v0.17.0.pre

* enhancements
  * Add customizable pagination size when sending `paginated: false` parameter to `#all` requests.

### v0.16.1.pre

* bug-fixes
  * Fix method to retrieve resources without pagination

### v0.16.0.pre

* features
  * Add pickup options methods
    * `PickupOptions#delete`
    * `PickupOptions#find`
    * `PickupOptions#sort`
    * `PickupOptions#update`

### v0.15.0.pre

* features
  * Add pickup options methods
    * `PickupOptions#all`
    * `PickupOptions#create`

### v0.14.0.pre

* deprecations
  * Remove `Products#assign_variation_images_differentiator`

* features
  * Add `Products#assign_variation_attribute_as_differentiator`

### v0.13.0.pre

* features
  * Add payment method definitions methods
    * `PaymentMethodDefinitions#all`
    * `PaymentMethodDefinitions#create`
    * `PaymentMethodDefinitions#delete`
    * `PaymentMethodDefinitions#find`
    * `PaymentMethodDefinitions#update`
  * Add possibility to log request `headers` and `bodies`

### v0.12.1.pre

* bug-fixes
  * Fix camelize function for hashes containing arrays

### v0.12.0.pre

* features
  * Add locations methods
    * `Locations#all`
    * `Locations#create`
    * `Locations#delete`
    * `Locations#find`
    * `Locations#update`

* enhancements
  * Use `autoload` instead of `require`

### v0.11.1.pre

* bug-fixes
  * Use `BeyondApi::Error` for authentication errors

### v0.11.0.pre

* enhancements
  * Improve error handling class
  * Improve `BeyondApi::Error` class

### v0.10.0.pre

* features
  * Add optional `paginated: false` parameter to `session.categories_view.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.categories.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.customers.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.orders.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.payment_methods.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.products_view.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.script_tags.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.shipping_zones.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.users.all(paginated: false)`
  * Add optional `paginated: false` parameter to `session.webhook_subscriptions.all(paginated: false)`

### v0.9.0.pre

* bug-fixes
  * Fix typo

* features
  * Add optional `paginated: false` parameter to `session.products.all(paginated: false)`

### v0.8.1.pre

* bug-fixes
  * Fix exception handling

### v0.8.0.pre

* deprecations
  * Remove `BeyondApi::Shop#open`
  * Remove `BeyondApi::Shop#close`
  * Remove `BeyondApi::Scopes`

* features
  * Add `BeyondApi::Token#client_credentials`

* enhancements
  * Create a custom `BeyondApi::Error` class
  * Avoid duplicated code on token response handling

### v0.7.1.pre

* bug-fixes
  * Allow to create a `BeyondApi::Session` without `access_token` and `refresh_token`
  * Fix no-Rails logger

### v0.7.0.pre

* deprecations
  * `Variations#adjust_stock_level` receives parameter `relative_amount` instead of `body`

* features
  * Add `Products#assign_variation_images_differentiator` method

### v0.6.0.pre

* bug-fixes
  * Fix `Carts#create` method
  * Fix `Carts#set_shipping_method_to_default` method
  * Fix `OrderSettings#update` method
  * Fix `Orders#capture_payment_process` method
  * Fix `Orders#create_cancelation_process` method
  * Fix `Products#attachments` method
  * Fix `Products#adjust_stock_level` method
  * Fix `Products#add_image` method
  * Fix `Products#set_image_as_default` method
  * Fix `ProductsView#all` method
  * Fix `Shops#legal_content` method
  * Fix `Shops#legal_contents` method
  * Fix `Shops#update` method
  * Fix `Users#verify_password` method

* deprecations
  * Remove `Orders#send_invoice` method
  * Remove all product_settings methods
  * Remove `ProductsView#search_by_query` method
  * `Orders#update_order_note` receives parameter `order_note` instead of `body`
  * `Products#adjust_stock_level` receives parameter `relative_amount` instead of `body`
  * `Products#update_reserve_stock` receives parameter `stock_threshold` instead of `body`

* features
  * Add customers methods
    * `Customers#all`
    * `Customers#create`
    * `Customers#delete`
    * `Customers#find`
    * `Customers#update`
  * Add `Orders#send_order_document` method
  * Add products cross-sells methods
    * `ProductCrossSells#create_cross_sell`
    * `ProductCrossSells#cross_sell`
    * `ProductCrossSells#cross_sells`
    * `ProductCrossSells#delete_cross_sell`
    * `ProductCrossSells#update_cross_sell`
  * Add products videos methods
    * `ProductVideos#add_video`
    * `ProductVideos#delete_video`
    * `ProductVideos#update_video`
    * `ProductVideos#video`
    * `ProductVideos#videos`
  * Add `Products#sort_images` method
  * Add variation images methods
    * `VariationImages#add_image`
    * `VariationImages#delete_image`
    * `VariationImages#image`
    * `VariationImages#images`
    * `VariationImages#upload_image`

### v0.5.1.pre

* bug-fixes
  * Fix `Products#adjust_stock_level` method

### v0.5.0.pre

* bug-fixes
  * Fix handling of array as request body
  * Include `BeyondApi::ProductAttachments` module into `BeyondApi::Products` class
  * Include `BeyondApi::ProductAvailability` module into `BeyondApi::Products` class
  * Include `BeyondApi::ProductSearches` module into `BeyondApi::Products` class
  * Include `BeyondApi::ProductVariationProperties` module into `BeyondApi::Products` class
  * Include `BeyondApi::VariationAvailability` module into `BeyondApi::Variations` class

### v0.4.0.pre

* bug-fixes
  * Fix `ProductAttributeDefinitions#create` method
  * Fix `ProductAttributeDefinitions#delete` method
  * Fix product custom attribute module name
  * Include `BeyondApi::ProductCustomAttributes` module into `BeyondApi::Products` class
  * Include `BeyondApi::ProductImages` module into `BeyondApi::Products` class

* enhancements
  * Allow to get all product attribute definitions on a single call

### v0.3.0.pre

* bug-fixes
  * Fix logger

* features
  * Add a configurable option to raise on error requests

### v0.2.1.pre

* features
  * Add logger option

### v0.2.0.pre

* bug-fixes
  * Fix the signers delete endpoint

* enhancements
  * Add better documentation

### v0.1.0.pre

* features
  * All endpoints offered by the Beyond API
