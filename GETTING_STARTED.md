# Getting started

## Get your credentials

### Sign up for a developer test shop

First you will need to sign up for a Beyond test shop.
Visit [our sign up form](https://signup.beyondshop.cloud), fill out the form with your data, and click the **Sign up** button.

### Create a custom app

Log in to the cockpit of your test shop, navigate to **Apps > Custom apps** and click **Add custom app**.
Fill out the form with the **App name**, **Application Callback URL** and **App scopes**.
Save your app.

You will then receive your `client_id` and `client_secret`.

## Authenticating a shop (the session object)

### Obtaining a token from an authentication code

```ruby
session = BeyondApi::Session.new(api_url: "https://your-shop-name.beyondshop.cloud/api")
session.token.create("your-auth-code")
```

> You can get an authentication code by clicking the **Test authorization** button in your test shop's cockpit on your custom app's page.
Clicking the button will redirect you to the **Application Callback URL** you have specified, attaching the code as a query parameter.

### Obtaining a token from a refresh token

```ruby
session = BeyondApi::Session.new(api_url: "https://your-shop-name.beyondshop.cloud/api",
                                 refresh_token: "your-refresh-token")
session.token.refresh
```

## Consuming the API

Here you can find a list with all available methods:

* Carts
  * `session.carts.add_line_item(cart_id, body)`
  * `session.carts.create(body)`
  * `session.carts.create_order(cart_id, body)`
  * `session.carts.create_payment(cart_id, body)`
  * `session.carts.create_payment_and_order(cart_id, body)`
  * `session.carts.delete(cart_id)`
  * `session.carts.delete_line_item(cart_id, line_item_id)`
  * `session.carts.delete_shipping_address(cart_id)`
  * `session.carts.find(cart_id)`
  * `session.carts.payment_method(cart_id)`
  * `session.carts.payment_methods(cart_id)`
  * `session.carts.replace_line_item(cart_id, line_item_id, body)`
  * `session.carts.replace_line_items(cart_id, body)`
  * `session.carts.set_billing_address(cart_id, body)`
  * `session.carts.set_payment_method(cart_id, payment_method_id)`
  * `session.carts.set_payment_method_to_default(cart_id)`
  * `session.carts.set_shipping_address(cart_id, body)`
  * `session.carts.set_shipping_method(cart_id, shipping_zone_id, shipping_method_id)`
  * `session.carts.set_shipping_method_to_default(cart_id)`
  * `session.carts.shipping_method(cart_id)`
  * `session.carts.shipping_methods(cart_id)`
* Category view
  * `session.categories_view.all(params = {})`
  * `session.categories_view.find(category_id)`
  * `session.categories_view.products(category_id, params = {})`
  * `session.categories_view.search_by_label(label)`
  * `session.categories_view.search_by_product(body, params = {})`
  * `session.categories_view.search_by_product_id(product_id, params = {})`
* Categories
  * `session.categories.all(params = {})`
  * `session.categories.create(body)`
  * `session.categories.delete(category_id)`
  * `session.categories.find(category_id)`
  * `session.categories.patch(category_id, body)`
  * `session.categories.update(category_id, body)`
* Checkout settings
  * `session.checkout_settings.all`
  * `session.checkout_settings.update(body)`
* Newsletter targets
  * `session.newsletter_target.create(submit_url)`
  * `session.newsletter_target.delete`
  * `session.newsletter_target.find`
  * `session.newsletter_target.update(submit_url)`
* Order settings
  * `session.order_settings.all(params = {})`
  * `session.order_settings.update(order_settings, body)`
* Orders
  * `session.orders.active_payment_process(order_id)`
  * `session.orders.active_refund_process(order_id)`
  * `session.orders.all(params = {})`
  * `session.orders.cancel(order_id, body)`
  * `session.orders.cancelation_process(order_id, cancelation_id)`
  * `session.orders.cancelation_processes(order_id, params = {})`
  * `session.orders.capture_payment_process(order_id, payment_id)`
  * `session.orders.create_cancelation_process(order_id, body)`
  * `session.orders.create_invoice(order_id, body)`
  * `session.orders.create_return_process(order_id, body)`
  * `session.orders.create_shipping_process(order_id, body)`
  * `session.orders.events(order_id, params = {})`
  * `session.orders.find(order_id)`
  * `session.orders.mark_payment_process_as_paid(order_id, payment_id, body)`
  * `session.orders.mark_payment_process_as_voided(order_id, payment_id, body)`
  * `session.orders.mark_refund_process_as_paid(order_id)`
  * `session.orders.mark_shipping_process_as_delivered(order_id, shipping_process_id, body)`
  * `session.orders.mark_shipping_process_as_shipped(order_id, shipping_id, body)`
  * `session.orders.payment_process(order_id, payment_id)`
  * `session.orders.payment_processes(order_id, params = {})`
  * `session.orders.processes(order_id)`
  * `session.orders.refund_process(order_id, refund_id)`
  * `session.orders.refund_processes(order_id, params = {})`
  * `session.orders.return_process(order_id, return_process_id)`
  * `session.orders.return_processes(order_id, params = {})`
  * `session.orders.search_by_cart_id(cart_id)`
  * `session.orders.search_order_number_by_cart_id(cart_id)`
  * `session.orders.send_invoice(order_id)`
  * `session.orders.shipping_process(order_id, shipping_process_id)`
  * `session.orders.shipping_processes(order_id, params = {})`
  * `session.orders.update_billing_address(order_id, body)`
  * `session.orders.update_order_note(order_id, body)`
  * `session.orders.update_shipping_address(order_id, body)`
* Payment methods
  * `session.payment_methods.activate(payment_method_id)`
  * `session.payment_methods.all(params = {})`
  * `session.payment_methods.deactivate(payment_method_id)`
  * `session.payment_methods.find(payment_method_id)`
  * `session.payment_methods.sort(payment_method_ids)`
  * `session.payment_methods.update(payment_method_id, body)`
* Product attribute definitions
  * `session.product_attribute_definitions.all(params = {})`
  * `session.product_attribute_definitions.create(product_attribute_name)`
  * `session.product_attribute_definitions.delete(product_attribute_name)`
  * `session.product_attribute_definitions.find(product_attribute_name)`
* Product settings
  * `session.product_settings.all`
* Product view
  * `session.products_view.all(params = {})`
  * `session.products_view.available_tags`
  * `session.products_view.find(product_id)`
  * `session.products_view.search_by_query(query)`
  * `session.products_view.search_by_tag(tag, params = {})`
  * `session.products_view.search_by_term(term, params = {})`
* Products
  * `session.products.all(params = {})`
  * `session.products.create(body)`
  * `session.products.create_variation(body)`
  * `session.products.delete(product_id)`
  * `session.products.find(product_id)`
  * `session.products.find_variation(product_id)`
  * `session.products.update(product_id, body)`
  * `session.products.update_variation(product_id, body)`
* Scopes
  * `session.scopes.all(params = {})`
* Script tags
  * `session.script_tags.all(params = {})`
  * `session.script_tags.create(script_tag_url)`
  * `session.script_tags.delete(script_tag_id)`
  * `session.script_tags.find(script_tag_id)`
  * `session.script_tags.update(script_tag_id, script_tag_url)`
* Shipping Zones
  * `session.shipping_zones.all(params = {})`
  * `session.shipping_zones.create(body)`
  * `session.shipping_zones.create_shipping_method(shipping_zone_id, body)`
  * `session.shipping_zones.delete(shipping_zone_id)`
  * `session.shipping_zones.delete_shipping_method(shipping_zone_id, shipping_method_id)`
  * `session.shipping_zones.find(shipping_zone_id)`
  * `session.shipping_zones.find_serviceable_countries`
  * `session.shipping_zones.shipping_method(shipping_zone_id, shipping_method_id)`
  * `session.shipping_zones.shipping_methods(shipping_zone_id, params = {})`
  * `session.shipping_zones.sort(shipping_zone_ids)`
  * `session.shipping_zones.sort_shipping_methods(shipping_zone_id)`
  * `session.shipping_zones.update(shipping_zone_id, body)`
* Shop
  * `session.shop.address`
  * `session.shop.attribute(attribute_name)`
  * `session.shop.attributes(params = {})`
  * `session.shop.close`
  * `session.shop.create_attribute(body)`
  * `session.shop.create_image(body)`
  * `session.shop.current`
  * `session.shop.delete_attribute(attribute_name)`
  * `session.shop.delete_image(image_id)`
  * `session.shop.image(image_id)`
  * `session.shop.images(params = {})`
  * `session.shop.legal_content(legal_content_type)`
  * `session.shop.legal_contents(params = {})`
  * `session.shop.legal_details`
  * `session.shop.open`
  * `session.shop.search_images_by_label(label)`
  * `session.shop.update(body)`
  * `session.shop.update_address(body)`
  * `session.shop.update_attribute(attribute_name, body)`
  * `session.shop.update_legal_content(body)`
  * `session.shop.update_legal_details(body)`
  * `session.shop.upload_image(image_path, image_name, label)`
* Signers
  * `session.signers.all`
  * `session.signers.create`
  * `session.signers.delete(signer_id)`
* Token
  * `session.token.create(code)`
  * `session.token.refresh`
* Users
  * `session.users.add_roles(user_id, body)`
  * `session.users.all(params = {})`
  * `session.users.change_password(user_id, current_password, new_password)`
  * `session.users.change_username(user_id, new_username, current_password)`
  * `session.users.create(body)`
  * `session.users.disable_support_access`
  * `session.users.enable_support_access`
  * `session.users.find(user_id)`
  * `session.users.roles(user_id)`
  * `session.users.search_by_username(username)`
  * `session.users.send_email_address_change(user_id, new_email, current_password, locale)`
  * `session.users.send_reset_password_email(email, locale)`
  * `session.users.set_roles(user_id, body)`
  * `session.users.support_access`
  * `session.users.verify_password(password)`
* Variations
  * `session.variations.all(product_id, params = {})`
  * `session.variations.find(product_id, variation_id)`
  * `session.variations.update(product_id, variation_id, body)`
* Webhook subscriptions
  * `session.webhook_subscriptions.activate(webhook_subscription_id)`
  * `session.webhook_subscriptions.all(params = {})`
  * `session.webhook_subscriptions.create(body)`
  * `session.webhook_subscriptions.deactivate(webhook_subscription_id)`
  * `session.webhook_subscriptions.delete(webhook_subscription_id)`
  * `session.webhook_subscriptions.find(webhook_subscription_id)`
  * `session.webhook_subscriptions.update(webhook_subscription_id, body)`
