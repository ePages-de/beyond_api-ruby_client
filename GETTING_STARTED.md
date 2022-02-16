# Getting started

## Authenticating a shop (the session object)

### Obtaining a token from an authentication code

```ruby
session = BeyondApi::Session.new(api_url: "https://your-shop-name.beyondshop.cloud/api")
session.token.authorization_code("your-auth-code")
```

> You can get an authentication code by clicking the **Test authorization** button in your test shop's cockpit on your custom app's page.
Clicking the button will redirect you to the **Application Callback URL** you have specified, attaching the code as a query parameter.

### Obtaining a token from a refresh token

```ruby
session = BeyondApi::Session.new(api_url: "https://your-shop-name.beyondshop.cloud/api")
session.token.refresh_token
```

> Requires valid `refresh_token` to exist on the `BeyondApi::Session` object.

### Obtaining a token from client credentials

```ruby
session = BeyondApi::Session.new(api_url: "https://your-shop-name.beyondshop.cloud/api")
session.token.client_credentials
```

## Consuming the API

Check the [_rubydoc_ documentation](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client) for more information on the Beyond API Ruby Client.

Here you can find a list with all available methods:

* Carts
  * [`session.carts.add_line_item(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#add_line_item-instance_method)
  * [`session.carts.create`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#create-instance_method)
  * [`session.carts.create_order(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#create_order-instance_method)
  * [`session.carts.create_payment(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#create_payment-instance_method)
  * [`session.carts.create_payment_and_order(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#create_payment_and_order-instance_method)
  * [`session.carts.delete(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#delete-instance_method)
  * [`session.carts.delete_line_item(cart_id, line_item_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#delete_line_item-instance_method)
  * [`session.carts.delete_shipping_address(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#delete_shipping_address-instance_method)
  * [`session.carts.find(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#find-instance_method)
  * [`session.carts.payment_method(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#payment_method-instance_method)
  * [`session.carts.payment_methods(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#payment_methods-instance_method)
  * [`session.carts.replace_line_item(cart_id, line_item_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#replace_line_item-instance_method)
  * [`session.carts.replace_line_items(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#replace_line_items-instance_method)
  * [`session.carts.set_billing_address(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#set_billing_address-instance_method)
  * [`session.carts.set_payment_method(cart_id, payment_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#set_payment_method-instance_method)
  * [`session.carts.set_payment_method_to_default(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#set_payment_method_to_default-instance_method)
  * [`session.carts.set_shipping_address(cart_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#set_shipping_address-instance_method)
  * [`session.carts.set_shipping_method(cart_id, shipping_zone_id, shipping_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#set_shipping_method-instance_method)
  * [`session.carts.set_shipping_method_to_default(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#set_shipping_method_to_default-instance_method)
  * [`session.carts.shipping_method(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#shipping_method-instance_method)
  * [`session.carts.shipping_methods(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Carts#shipping_methods-instance_method)
* Categories view
  * [`session.categories_view.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CategoriesView#all-instance_method)
  * [`session.categories_view.find(category_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CategoriesView#find-instance_method)
  * [`session.categories_view.products(category_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CategoriesView#products-instance_method)
  * [`session.categories_view.search_by_label(label)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CategoriesView#search_by_label-instance_method)
  * [`session.categories_view.search_by_product(body, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CategoriesView#search_by_product-instance_method)
  * [`session.categories_view.search_by_product_id(product_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CategoriesView#search_by_product_id-instance_method)
* Categories
  * [`session.categories.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Categories#all-instance_method)
  * [`session.categories.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Categories#create-instance_method)
  * [`session.categories.delete(category_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Categories#delete-instance_method)
  * [`session.categories.find(category_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Categories#find-instance_method)
  * [`session.categories.patch(category_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Categories#patch-instance_method)
  * [`session.categories.update(category_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Categories#update-instance_method)
* Checkout settings
  * [`session.checkout_settings.all`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CheckoutSettings#all-instance_method)
  * [`session.checkout_settings.update(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/CheckoutSettings#update-instance_method)
* Token
  * [`session.token.client_credentials`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Token#client_credentials-instance_method)
  * [`session.token.create(code)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Token#create-instance_method)
  * [`session.token.refresh`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Token#refresh-instance_method)
  * [`session.token.session`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Token#session-instance_method)
* Customers
  * [`session.customers.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Customers#all-instance_method)
  * [`session.customers.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Customers#create-instance_method)
  * [`session.customers.delete(customer_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Customers#delete-instance_method)
  * [`session.customers.find(customer_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Customers#find-instance_method)
  * [`session.customers.update(customer_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Customers#update-instance_method)
* Newsletter target
  * [`session.newsletter_target.create(submit_url)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/NewsletterTarget#create-instance_method)
  * [`session.newsletter_target.delete`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/NewsletterTarget#delete-instance_method)
  * [`session.newsletter_target.find`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/NewsletterTarget#find-instance_method)
  * [`session.newsletter_target.update(submit_url)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/NewsletterTarget#update-instance_method)
* Order settings
  * [`session.order_settings.all`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/OrderSettings#all-instance_method)
  * [`session.order_settings.update(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/OrderSettings#update-instance_method)
* Orders
  * [`session.orders.active_payment_process(order_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#active_payment_process-instance_method)
  * [`session.orders.active_refund_process(order_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#active_refund_process-instance_method)
  * [`session.orders.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#all-instance_method)
  * [`session.orders.cancel(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#cancel-instance_method)
  * [`session.orders.cancelation_process(order_id, cancelation_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#cancelation_process-instance_method)
  * [`session.orders.cancelation_processes(order_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#cancelation_processes-instance_method)
  * [`session.orders.capture_payment_process(order_id, payment_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#capture_payment_process-instance_method)
  * [`session.orders.create_cancelation_process(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#create_cancelation_process-instance_method)
  * [`session.orders.create_invoice(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#create_invoice-instance_method)
  * [`session.orders.create_return_process(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#create_return_process-instance_method)
  * [`session.orders.create_shipping_process(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#create_shipping_process-instance_method)
  * [`session.orders.events(order_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#events-instance_method)
  * [`session.orders.find(order_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#find-instance_method)
  * [`session.orders.mark_payment_process_as_paid(order_id, payment_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#mark_payment_process_as_paid-instance_method)
  * [`session.orders.mark_payment_process_as_voided(order_id, payment_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#mark_payment_process_as_voided-instance_method)
  * [`session.orders.mark_refund_process_as_paid(order_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#mark_refund_process_as_paid-instance_method)
  * [`session.orders.mark_shipping_process_as_delivered(order_id, shipping_process_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#mark_shipping_process_as_delivered-instance_method)
  * [`session.orders.mark_shipping_process_as_shipped(order_id, shipping_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#mark_shipping_process_as_shipped-instance_method)
  * [`session.orders.payment_process(order_id, payment_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#payment_process-instance_method)
  * [`session.orders.payment_processes(order_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#payment_processes-instance_method)
  * [`session.orders.processes(order_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#processes-instance_method)
  * [`session.orders.refund_process(order_id, refund_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#refund_process-instance_method)
  * [`session.orders.refund_processes(order_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#refund_processes-instance_method)
  * [`session.orders.return_process(order_id, return_process_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#return_process-instance_method)
  * [`session.orders.return_processes(order_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#return_processes-instance_method)
  * [`session.orders.search_by_cart_id(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#search_by_cart_id-instance_method)
  * [`session.orders.search_order_number_by_cart_id(cart_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#search_order_number_by_cart_id-instance_method)
  * [`session.orders.send_order_document(order_id, order_document_uri)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#send_order_document-instance_method)
  * [`session.orders.shipping_process(order_id, shipping_process_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#shipping_process-instance_method)
  * [`session.orders.shipping_processes(order_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#shipping_processes-instance_method)
  * [`session.orders.update_billing_address(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#update_billing_address-instance_method)
  * [`session.orders.update_order_note(order_id, order_note)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#update_order_note-instance_method)
  * [`session.orders.update_shipping_address(order_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Orders#update_shipping_address-instance_method)
* Payment methods
  * [`session.payment_methods.activate(payment_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/PaymentMethods#activate-instance_method)
  * [`session.payment_methods.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/PaymentMethods#all-instance_method)
  * [`session.payment_methods.deactivate(payment_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/PaymentMethods#deactivate-instance_method)
  * [`session.payment_methods.find(payment_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/PaymentMethods#find-instance_method)
  * [`session.payment_methods.sort(payment_method_ids)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/PaymentMethods#sort-instance_method)
  * [`session.payment_methods.update(payment_method_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/PaymentMethods#update-instance_method)
* Product attribute definitions
  * [`session.product_attribute_definitions.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductAttributeDefinitions#all-instance_method)
  * [`session.product_attribute_definitions.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductAttributeDefinitions#create-instance_method)
  * [`session.product_attribute_definitions.delete(product_attribute_name)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductAttributeDefinitions#delete-instance_method)
  * [`session.product_attribute_definitions.find(product_attribute_name)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductAttributeDefinitions#find-instance_method)
* Products view
  * [`session.products_view.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductsView#all-instance_method)
  * [`session.products_view.available_tags`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductsView#available_tags-instance_method)
  * [`session.products_view.find(product_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductsView#find-instance_method)
  * [`session.products_view.search_by_tag(tag, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductsView#search_by_tag-instance_method)
  * [`session.products_view.search_by_term(term, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ProductsView#search_by_term-instance_method)
* Products
  * [`session.products.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#all-instance_method)
  * [`session.products.assign_variation_images_differentiator(product_id, differentiator)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#assign_variation_images_differentiator-instance_method)
  * [`session.products.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#create-instance_method)
  * [`session.products.create_variation(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#create_variation-instance_method)
  * [`session.products.delete(product_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#delete-instance_method)
  * [`session.products.find(product_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#find-instance_method)
  * [`session.products.find_variation(product_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#find_variation-instance_method)
  * [`session.products.update(product_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#update-instance_method)
  * [`session.products.update_variation(product_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Products#update_variation-instance_method)
* Script tags
  * [`session.script_tags.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ScriptTags#all-instance_method)
  * [`session.script_tags.create(script_tag_url)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ScriptTags#create-instance_method)
  * [`session.script_tags.delete(script_tag_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ScriptTags#delete-instance_method)
  * [`session.script_tags.find(script_tag_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ScriptTags#find-instance_method)
  * [`session.script_tags.update(script_tag_id, script_tag_url)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ScriptTags#update-instance_method)
* Shipping zones
  * [`session.shipping_zones.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#all-instance_method)
  * [`session.shipping_zones.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#create-instance_method)
  * [`session.shipping_zones.create_shipping_method(shipping_zone_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#create_shipping_method-instance_method)
  * [`session.shipping_zones.delete(shipping_zone_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#delete-instance_method)
  * [`session.shipping_zones.delete_shipping_method(shipping_zone_id, shipping_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#delete_shipping_method-instance_method)
  * [`session.shipping_zones.find(shipping_zone_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#find-instance_method)
  * [`session.shipping_zones.find_serviceable_countries`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#find_serviceable_countries-instance_method)
  * [`session.shipping_zones.shipping_method(shipping_zone_id, shipping_method_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#shipping_method-instance_method)
  * [`session.shipping_zones.shipping_methods(shipping_zone_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#shipping_methods-instance_method)
  * [`session.shipping_zones.sort(shipping_zone_ids)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#sort-instance_method)
  * [`session.shipping_zones.sort_shipping_methods(shipping_zone_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#sort_shipping_methods-instance_method)
  * [`session.shipping_zones.update(shipping_zone_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/ShippingZones#update-instance_method)
* Shop
  * [`session.shop.address`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#address-instance_method)
  * [`session.shop.attribute(attribute_name)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#attribute-instance_method)
  * [`session.shop.attributes(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#attributes-instance_method)
  * [`session.shop.create_attribute(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#create_attribute-instance_method)
  * [`session.shop.create_image(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#create_image-instance_method)
  * [`session.shop.current`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#current-instance_method)
  * [`session.shop.delete_attribute(attribute_name)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#delete_attribute-instance_method)
  * [`session.shop.delete_image(image_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#delete_image-instance_method)
  * [`session.shop.image(image_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#image-instance_method)
  * [`session.shop.images(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#images-instance_method)
  * [`session.shop.legal_content(legal_content_type)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#legal_content-instance_method)
  * [`session.shop.legal_contents(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#legal_contents-instance_method)
  * [`session.shop.legal_details`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#legal_details-instance_method)
  * [`session.shop.search_images_by_label(label)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#search_images_by_label-instance_method)
  * [`session.shop.update(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#update-instance_method)
  * [`session.shop.update_address(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#update_address-instance_method)
  * [`session.shop.update_attribute(attribute_name, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#update_attribute-instance_method)
  * [`session.shop.update_legal_content(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#update_legal_content-instance_method)
  * [`session.shop.update_legal_details(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#update_legal_details-instance_method)
  * [`session.shop.upload_image(image_path, image_name, label)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Shop#upload_image-instance_method)
* Signers
  * [`session.signers.all`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Signers#all-instance_method)
  * [`session.signers.create`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Signers#create-instance_method)
  * [`session.signers.delete(signer_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Signers#delete-instance_method)
* Users
  * [`session.users.add_roles(user_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#add_roles-instance_method)
  * [`session.users.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#all-instance_method)
  * [`session.users.change_password(user_id, current_password, new_password)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#change_password-instance_method)
  * [`session.users.change_username(user_id, new_username, current_password)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#change_username-instance_method)
  * [`session.users.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#create-instance_method)
  * [`session.users.disable_support_access`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#disable_support_access-instance_method)
  * [`session.users.enable_support_access`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#enable_support_access-instance_method)
  * [`session.users.find(user_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#find-instance_method)
  * [`session.users.roles(user_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#roles-instance_method)
  * [`session.users.search_by_username(username)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#search_by_username-instance_method)
  * [`session.users.send_email_address_change(user_id, new_email, current_password, locale)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#send_email_address_change-instance_method)
  * [`session.users.send_reset_password_email(email, locale)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#send_reset_password_email-instance_method)
  * [`session.users.set_roles(user_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#set_roles-instance_method)
  * [`session.users.support_access`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#support_access-instance_method)
  * [`session.users.verify_password(password, user_role)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Users#verify_password-instance_method)
* Variations
  * [`session.variations.all(product_id, params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Variations#all-instance_method)
  * [`session.variations.find(product_id, variation_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Variations#find-instance_method)
  * [`session.variations.update(product_id, variation_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/Variations#update-instance_method)
* Webhook subscriptions
  * [`session.webhook_subscriptions.activate(webhook_subscription_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#activate-instance_method)
  * [`session.webhook_subscriptions.all(params = {})`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#all-instance_method)
  * [`session.webhook_subscriptions.create(body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#create-instance_method)
  * [`session.webhook_subscriptions.deactivate(webhook_subscription_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#deactivate-instance_method)
  * [`session.webhook_subscriptions.delete(webhook_subscription_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#delete-instance_method)
  * [`session.webhook_subscriptions.find(webhook_subscription_id)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#find-instance_method)
  * [`session.webhook_subscriptions.update(webhook_subscription_id, body)`](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client/BeyondApi/WebhookSubscriptions#update-instance_method)
