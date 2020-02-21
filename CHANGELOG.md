### v0.7.1.pre

* bug-fixes
  * Allow to create a `BeyondApi::Session` without `access_token` and `refresh_token`
  * Fix no-Rails logger

### v0.7.0.pre

* features
  * Add `Products#assign_variation_images_differentiator` method

* deprecations
  * `Variations#adjust_stock_level` receives parameter `relative_amount` instead of `body`

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
