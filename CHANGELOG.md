### v0.6.0.pre

* bug-fixes
  * Fix carts `create` method
  * Fix carts `set_shipping_method_to_default` method
  * Fix order settings `update` method
  * Fix orders `capture_payment_process` method
  * Fix orders `create_cancelation_process` method
  * Fix products `attachments` method
  * Fix products `adjust_stock_level` method
  * Fix products `add_image` method
  * Fix products `set_image_as_default` method
  * Fix product_view_products `all` method
  * Fix shops `legal_content` method
  * Fix shops `legal_contents` method
  * Fix shops `update` method
  * Fix users `verify_password` method

* features
  * Remove orders `send_invoice` method
  * Remove all product_settings methods
  * Remove product_view_products `search_by_query` method
  * Add customers methods
  * Add orders `send_order_document` method
  * Add products cross-sells methods
  * Add products videos methods
  * Add products `sort_images` method
  * Add variation images methods

### v0.5.1.pre

* bug-fixes
  * Fix `adjust_stock_level` method

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
  * Fix product attribute definition `create` method
  * Fix product attribute definition `delete` method
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
