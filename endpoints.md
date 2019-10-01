⚠️ = Deprecated

⛔ = Won't do

✅ = Checked

🌞 = On the Ruby Api

## 1. Change Log

## 2. Authentication

#### 2.1. ✅ Create a JsonWebToken from Refresh Token 🌞

A `POST` request is used to create a JsonWebToken from a refresh token.

```ruby
# POST /oauth/token
session.token.create(code)
```

#### 2.2. ✅ Create a JsonWebToken from Client Credentials 🌞

A `POST` request is used to create a JsonWebToken using the client_credentials grant type.

```ruby
# POST /oauth/token
session.token.refresh
```

## 3. Carts

The `cart` resources are used to manage the carts of a shop. A cart allows customers to pick products from a shop and store them to be bought now or at a later time. The cart can contain a single or various line items. The cart also holds the feature for setting the billing address, the shipping address and shipping zone as well as the payment method.

#### 3.1. ✅ Create cart 🌞

A `POST` request is used to create a cart.

```ruby
# POST /carts
session.carts.create
```

#### 3.2. ✅ Show cart details 🌞

A `GET` request is used to retrieve the details of a cart.

```ruby
# GET /carts/ce127327-55c4-4a9a-9870-77d397dd1a4b
session.carts.find(cart_id)
```

#### 3.3. ✅ Delete cart 🌞

A `DELETE` request is used to remove the cart.

```ruby
# DELETE /carts/8fe86cba-502c-4f9a-8f4c-89f8b81a6e21
session.carts.delete(cart_id)
```

#### 3.4. ✅ Create order from cart 🌞

A `POST` request is used to create an order from the cart.

```ruby
# POST /carts/dfc027da-5e27-45a1-a520-19e5ea4a77ab/order
session.carts.create_order(cart_id, body)
```

#### 3.5. ✅ Add single line item to cart 🌞

A `POST` request is used to add a line item to the cart. Currently only product line items are supported.

```ruby
# POST /carts/41b6a4b3-a53b-4c15-bcec-be38db5a4da9/line-items
session.carts.add_line_item(cart_id, body)
```

#### 3.6. ✅ Replace single line item 🌞

A `PUT` request is used to replace only one line item in the cart.

```ruby
# PUT /carts/97d1fe26-fee1-4a42-8147-8ef0aa8c9cc8/line-items/e3d3ec5b-5f5f-4756-9fd9-cc5072ed120b
session.carts.replace_line_item(cart_id, line_item_id, body)
```

#### 3.7. ✅ Replace line items 🌞

A `PUT` request is used to replace the current line items in the cart with the given list.

```ruby
# PUT /carts/467b31d1-9391-4dac-99aa-0be1143e6a03/line-items
session.carts.replace_line_items(cart_id, body)
```

#### 3.8. ✅ Delete line item 🌞

A `DELETE` request is used to delete a line item from the cart.

```ruby
# DELETE /carts/5b39d61f-d06d-4443-af66-ea1adb21c324/line-items/dc8b67d7-9a9c-48ee-bcaa-e8282d3bd4a4
session.carts.delete_line_item(cart_id, line_item_id)
```

#### 3.9. ✅ Set cart billing address 🌞

A `PUT` request is used to set the billing address of the cart. The billing address is mandatory for a cart being ready to order.

```ruby
# PUT /carts/f4eff2f2-6c28-40b3-b55f-18a38397ccd9/billing-address
session.carts.set_billing_address(cart_id, body)
```

#### 3.10. ✅ Set cart shipping address 🌞

A `PUT` request is used to set the shipping address of the cart. If a shipping address is not set, it will default to the billing address.

```ruby
# PUT /carts/dcaf4725-3f4f-4393-ad00-2fa54d52f5e9/shipping-address
session.carts.set_shipping_address(cart_id, body)
```

#### 3.11. ✅ Remove cart shipping address 🌞

A `DELETE` request is used to remove the shipping address of the cart. After deletion, the shipping address will default to the billing address.

```ruby
# DELETE /carts/543183d2-2f61-40b1-92b9-96eb9c0ae285/shipping-address
session.carts.delete_shipping_address(cart_id)
```

#### 3.12. ✅ Set current cart payment method 🌞

A `PUT` request is used to set the current payment method of the cart.

```ruby
# PUT /carts/d05e4a13-5515-442a-ace5-404f84d053c1/payment-methods/current
session.carts.set_payment_method(cart_id, payment_method_id)
```

#### 3.13. ✅ Set cart payment method to current default 🌞

A `PUT` request is used to set the payment method to the current default payment method. The default payment method is the one with the highest priority of the applicable payment methods.

```ruby
# PUT /carts/3a553331-8613-46aa-bc5b-0f99a838e6f6/payment-methods/default
session.carts.set_payment_method_to_default(cart_id)
```

#### 3.14. ✅ Show current cart payment method details 🌞

A `GET` request is used to get the current payment method. The payment method type is documented here. (8.1 - http://docs.beyondshop.cloud/#resources-payment-method-get)

```ruby
# GET /carts/464f8455-7b11-4f37-8ad3-87cf1ea4ef6b/payment-methods/current
session.carts.payment_method(cart_id)
```

#### 3.15. ✅ Show applicable cart payment method details 🌞

A `GET` request is used to get the applicable payment methods of a cart. The payment method type is documented here. (8.1 - http://docs.beyondshop.cloud/#resources-payment-method-get)

The `selectable` field indicates if a payment method is currently selectable. Non-selectable payment methods are currently restricted because of rules that apply to a cart. Trying to set such a payment method as the current one of the cart will fail.

```ruby
# GET /carts/679575cf-6535-469d-ab5c-21eb8f33db09/payment-methods
session.carts.payment_methods(cart_id)
```

#### 3.16. ✅ Create payment 🌞

A `POST` request is used to initiate the creation of a payment.

```ruby
# POST /carts/e925ad9e-04fd-44c0-ba80-eb25701acef5/create-payment
session.carts.create_payment(cart_id, body)
```

#### 3.17. ✅ Create payment and order 🌞

Initiates payment and order for the cart identified by {cartId} with a single `POST` request.

```ruby
# POST /carts/d67ace2b-f0a7-43ed-a3f7-a23a53bf6459/
session.carts.create_payment_and_order(cart_id, body)
```

## 4. Categories

The `categories` resource is used to manage the categories of a shop. In the merchant’s cockpit a category is referred to as "collection".

Categories can be used to organize products into hierarchical structures and to classify them in different ways, e.g. for shop navigation. Products can appear in any number of categories, and there can be multiple category hierarchies for different purposes or channels. Categories are embedded in the product search so that products can be filtered according to their assignment.

#### 4.1. ✅ List categories 🌞

A `GET` request will list all available categories in a paged manner.

```ruby
# GET /categories
session.categories.all(params = {})
```

#### 4.2. ✅ Create category 🌞

A `POST` request is used to create a category.

```ruby
# POST /categories
session.categories.create(body)
```

#### 4.3. ✅ Show category details 🌞

A `GET` request is used to retrieve the details of a category.

```ruby
# GET /categories/1a004827-71c7-4638-b830-2fa0ac9bbc59
session.categories.find(category_id)
```

#### 4.4. ✅ Update all category properties 🌞

A `PUT` request is issued to update all category properties with application/json content type.

```ruby
# PUT /categories/859741d4-5541-4215-9bdb-9d3ddfbc70fa
session.categories.update(category_id, body)
```

#### 4.5. ⛔ Update category partially (json patch)
```ruby
# PATCH /categories/ad3eadf2-bf2d-484f-b416-67c06d29750d
```

#### 4.6. ✅ Update category partially (json) 🌞

A `PATCH` request is used to update a category partially with json content type.

```ruby
# PATCH /categories/10dc5118-7358-4a68-82eb-93778567f0f8
session.categories.patch(category_id, body)
```

#### 4.7. ✅ Delete category 🌞

A `DELETE` request is used to delete a category.

```ruby
# DELETE /categories/d78d42f0-96bc-4f0b-a39e-a8cf822f5e9d
session.categories.delete(category_id)
```

#### 4.8. ✅ Show product category details 🌞

A `GET` request is used to retrieve the details of a product category.

```ruby
# GET /product-view/categories/1a004827-71c7-4638-b830-2fa0ac9bbc59
session.product_view_categories.find(category_id)
```

#### 4.9. ✅ List product categories 🌞

A `GET` request is used to list all product categories.

```ruby
# GET /product-view/categories
session.product_view_categories.all(params = {})
```

#### 4.10. ✅ List products 🌞

A `GET` request is used to list all products of a category.

```ruby
# GET /product-view/categories/080e0c0a-6b6c-469c-b144-ad3be828dc86/products
session.product_view_categories.products(category_id, params)
```

#### 4.11. ✅ List product categories assigned to an existing product 🌞

A `GET` request is used to list all product categories a product is part of using the request parameter `productId`.

For the response body properties see category list structure. (4.9 - http://docs.beyondshop.cloud/#productview-categories-list)

```ruby
# GET /product-view/categories/search/find-by-product?productId=2b30f793-a16a-4646-b16b-148ab340dfb4
session.product_view_categories.search_by_product_id(product_id, params)
```

#### 4.12. ✅ Search matching product categories for product 🌞

This `POST` request is read-only and cannot create data. It is used to search for categories a new product will be part of using the request body. An existing product can also be part of the call. This endpoint can handle all properties a product can have, see List products. (4.10 - http://docs.beyondshop.cloud/#product-view-list)

For the request body properties see product structure. (9.4 - http://docs.beyondshop.cloud/#product-view-find-by-id) For the response body properties see category list structure. (4.9 - http://docs.beyondshop.cloud/#productview-categories-list)

```ruby
# POST /product-view/categories/search/find-by-product
session.product_view_categories.search_by_product(body, params)
```

#### 4.13. ✅ Find product category by label 🌞

A `GET` request is used to find a product category by its unique label.

```ruby
# GET /product-view/categories/search/find-by-label?label=power-bar
session.product_view_categories.search_by_label(label)
```

## 5. Checkout

The `checkout settings` resources contain information about the minimum order value of a shop as well as indicate customer consent to the general terms and conditions of a shop.

#### 5.1. ✅ List checkout settings 🌞

A `GET` request is used to retrieve the checkout settings.

```ruby
# GET /checkout-settings
session.checkout_settings.all
```

#### 5.2. ✅ Update checkout settings 🌞

A `PUT` request is used to update the checkout settings.

```ruby
# PUT /checkout-settings
session.checkout_settings.update(body)
```

## 6. Orders

The `orders` resource is used to manage the orders of a shop. This includes all processes related to billing, shipping, payments, invoicing, as well as refunds, returns, and cancelations.

#### 6.1. ✅ List orders 🌞

A `GET` request is used to list all orders of the shop in a paged way. Each item in the response represents a summary of the order data.

```ruby
# GET /orders
session.orders.all
```

#### 6.2. ✅ Show order details 🌞

A `GET` request is used to retrieve the details of an order.

```ruby
# GET /orders/a11b4c95-12ca-48b1-a721-f21597dd1764
session.orders.find(order_id)
```

#### 6.3. ✅ Show order by cart Id 🌞

A `GET` request is used to retrieve the details of an order by cart ID.

```ruby
# GET /orders/search/find-by-cart-id?cartId=cf8e79cf-e3c3-4c55-b7dc-3c9ef36f8a04
session.orders.search_by_cart_id(cart_id)
```

#### 6.4. ✅ Show order number and order Id by cart Id 🌞

A `GET` request is used to retrieve the `orderNumber` and `orderId` of an order by cart Id. If there is no order for the given cart Id, a HTTP 404 - NOT FOUND response is returned.

```ruby
# GET /orders/search/find-order-number-by-cart-id?cartId=f3d7b7a0-332a-4895-a220-0e89057bbd60
session.orders.search_order_number_by_cart_id(cart_id)
```

#### 6.5. ✅ Update order note 🌞

A `PUT` request is used to change the order note.

```ruby
# PUT /orders/e34a5857-a980-4617-bb17-20c1415cb50d/order-note
session.orders.update_order_note(order_id, body)
```

#### 6.6. ✅ Update billing address 🌞

A `PUT` request is used to change the customer’s billing address.

```ruby
# PUT /orders/fb4c3b61-8386-45ea-af6d-92663510f264/billing-address
session.orders.update_billing_address(order_id, body)
```

#### 6.7. ✅ Update shipping address 🌞

A `PUT` request is used to change the customer’s shipping address.

```ruby
# PUT /orders/a35ee057-eaa4-4765-9c4f-7ccdaa791afb/shipping-address
session.orders.update_shipping_address(order_id, body)
```

#### 6.8. ✅ Create invoice 🌞

A `POST` request is used to create an invoice for the order.

```ruby
# POST /orders/1f71127f-e47c-461e-b790-7c72c85b9ce3/create-invoice
session.orders.create_invoice(order_id, body)
```

#### 6.9. ✅ Send invoice 🌞

A `POST` request is used to send an invoice for the order.

```ruby
# POST /orders/81a30b58-081c-4dac-b1e8-6348611d045d/send-invoice
session.orders.send_invoice(order_id)
```

#### 6.10. ✅ List order processes 🌞

A `GET` request is used to list all order processes.

```ruby
# GET /orders/2a5ebc2f-41df-4a53-8aa0-4c923938df5a/processes
session.orders.processes(order_id)
```

#### 6.11. ✅ List payment processes 🌞

A `GET` request is used to list all payment processes of an order in a paged way.

```ruby
# GET /orders/278f2986-a185-43a1-89ee-21b09ee2dcdf/processes/payments?page=0&size=20
session.orders.payment_processes(order_id, params) 🌞
```

#### 6.12. ✅ Show payment process details

A `GET` request is used to retrieve the payment processes.

```ruby
# GET /orders/ae913985-afdf-4ff4-b0cd-4baceaa0a8f7/processes/payments/52906964-cb44-45ad-8331-7fbd4a579ba1
session.orders.payment_process(order_id, payment_id) 🌞
```

#### 6.13. ✅ Show online payment process details 🌞

A `GET` request is used to retrieve the payment processes.

```ruby
# GET /orders/b09145b4-ca4e-469f-999d-b3361c787777/processes/payments/4d3077c9-53bb-442c-bc6b-93c6607d7a45
session.orders.payment_process(order_id, payment_id)
```

#### 6.14. ✅ Show active payment process details 🌞

A `GET` request is used to retrieve the active payment processes. There is only one active payment process. See Show payment process details for more information about the request and response structure. (6.12 - http://docs.beyondshop.cloud/#resources-payment-process-get)

```ruby
# GET /orders/f8bcb8b4-fc9f-44a6-9ad6-a982f2b6a05c/processes/payments/active
session.orders.active_payment_process(order_id)
```

#### 6.15. ✅ Mark payment process as voided 🌞

A `POST` request is used to mark the payment process as voided.

```ruby
# POST /orders/aea34cf6-969e-408d-bf2c-608c6c972076/processes/payments/fb56103b-9b7b-42fa-a2b8-b7a322ce1acf/mark-voided
session.orders.mark_payment_process_as_voided(order_id, payment_id, body)
```

#### 6.16. ✅ Mark payment process as paid 🌞

A `POST` request is used to mark the payment process as paid.

```ruby
# POST /orders/5156cbde-9fe9-4f84-b88d-57676cf77662/processes/payments/632db897-54c3-443e-a3bb-96d98fa740fc/mark-paid
session.orders.mark_payment_process_as_paid(order_id, payment_id, body)
```

#### 6.17. ✅ Capture payment 🌞

A `POST` request is used to capture the payment.

```ruby
# POST /orders/89c2d40f-96f6-4b69-a945-cbc5de4e0607/processes/payments/a66d6dda-001d-411a-9af4-10dab68aa8ea/capture
session.orders.capture_payment_process(order_id, payment_id)
```

#### 6.18. ✅ List refund processes 🌞

A `GET` request is used to list all refund processes of an order in a paged way. Refunds are triggered if either a cancelation or return process is created. See Create cancelation processes (6.32 - http://docs.beyondshop.cloud/#resources-cancel-processes-create) and Create return processes (6.29 - http://docs.beyondshop.cloud/#resources-return-processes-create) for more information.

```ruby
# GET /orders/bbc31b89-b511-454f-a735-16897351403c/processes/refunds?page=0&size=20
session.orders.refund_processes(order_id, params)
```

#### 6.19. ✅ Show refund process details 🌞

A `GET` request is used to retrieve the refund processes.

```ruby
# GET /orders/9233d627-4200-4b15-8344-de3481049c28/processes/refunds/ea0ac46b-b280-45d5-bc74-e8d2acb3a9bf
session.orders.refund_process(order_id, refund_id)
```

#### 6.20. ✅ Show active refund process details 🌞

A `GET` request is used to retrieve the active refund processes. There is only one active refund process. See Show refund process details (6.19 - http://docs.beyondshop.cloud/#resources-refund-process-get) for more information about the request and response structure.

```ruby
# GET /orders/4cc59a6b-0b0f-480f-959a-f293bd16fdf0/processes/refunds/active
session.orders.active_refund_process(order_id)
```

#### 6.21. ✅ Mark refund process as paid 🌞

A `POST` request is used to mark the refund process as paid.

```ruby
# POST /orders/1bc44b35-09c8-49fd-8dcf-b966872ef750/processes/refunds/active/mark-paid
session.orders.mark_refund_process_as_paid(order_id)
```

#### 6.22. ✅ List shipping processes 🌞

A `GET` request is used to list all shipping processes of an order in a paged way.

```ruby
# GET /orders/7fbe718b-da41-4b5d-8042-8d0af488cfee/processes/shippings?page=0&size=20
session.orders.shipping_processes(order_id, params)
```

#### 6.23. ✅ Show shipping process details 🌞

A `GET` request is used to retrieve the shipping process details.

```ruby
# GET /orders/d595870e-9eb3-465f-9c52-d1f1f4b63bff/processes/shippings/4312c065-e71b-46d7-abc5-e6684b686ae7
session.orders.shipping_process(order_id, shipping_id)
```

#### 6.24. ✅ Create shipping processes 🌞

A `POST` request is ussed to create a new shipping processes for an order.

```ruby
# POST /orders/c8b57d80-4c73-4986-9e37-133f4ad262b9/processes/shippings
session.orders.create_shipping_process(order_id, body)
```

#### 6.25. ✅ Mark shipment as shipped 🌞

A `POST` request is used to mark the shipment as shipped.

```ruby
# POST /orders/1576e985-f9e2-436c-b7e2-809bc6149cad/processes/shippings/42486574-785a-47bc-87f9-901580f5393a/mark-shipped
session.orders.mark_shipping_process_as_shipped(order_id, shipping_id)
```

#### 6.26. ✅ Mark shipment as delivered 🌞

A `POST` request is used to mark the shipment as delivered.

```ruby
# POST /orders/acbab603-e18d-4ed8-abdf-e63564d497a1/processes/shippings/3cb1bf19-6bb2-4064-8969-f1df84cff5d0/mark-delivered
session.orders.mark_shipping_process_as_delivered(order_id, shipping_id)
```

#### 6.27. ✅ List return processes 🌞

A `GET` request is used to list all return processes of an order in a paged way.

```ruby
# GET /orders/9136606c-0d46-42bb-8beb-8d8d5723f55f/processes/returns?page=0&size=20
session.orders.return_processes(order_id, params)
```

#### 6.28. ✅ Show return process details 🌞

A `GET` request is used to retrieve the return process details.

```ruby
# GET /orders/64e33cea-aa93-4e11-9b53-24b3f60c1d53/processes/returns/e72549df-8f98-4541-b5ce-07bb68cd3831
session.orders.return_process(order_id, return_id)
```

#### 6.29. ✅ Create return processes 🌞

A `POST` request is used to create a new return process for an order. Return processes trigger a refund process.

```ruby
# POST /orders/ede4f675-9520-449b-83f5-9ed05c0c5560/processes/returns
session.orders.create_return_process(order_id, body)
```

#### 6.30. ✅ List cancelation processes 🌞

A `GET` request is used to list all cancelation processes of an order in a paged way.

```ruby
# GET /orders/00b33d0a-16fb-4cb5-bcca-47f87eec5076/processes/cancelations?page=0&size=20
session.orders.cancelation_processes(order_id, params)
```

#### 6.31. ✅ Show cancelation process details 🌞

A `GET` request is used to retrieve the cancelation process details of an order.

```ruby
# GET /orders/32a4b485-3f89-4f8f-854b-e05c4609c779/processes/cancelations/df23e67f-1185-44a9-ace7-b349b66d1b98
session.orders.cancelation_process(order_id, cancelation_id)
```

#### 6.32. ✅ Create cancelation processes 🌞

A `POST` request is used to create a new cancelation process for an order. Cancelation processes trigger a refund process.

```ruby
# POST /orders/1cf0ab24-d828-4af5-b197-60f568fb1543/processes/cancelations
session.orders.create_cancelation_process(order_id, body)
```

#### 6.33. ✅ Cancel order 🌞

A `POST` request is used to cancel an order.

```ruby
# POST /orders/11b7dcc5-5ccd-4c38-b8c3-06453f7f1c06/cancel
session.orders.cancel(order_id)
```

#### 6.34. ✅ List order events 🌞

A `GET` request is used to list all events of an order in a paged way.

```ruby
# GET /orders/9dd6ef76-1aae-4771-80d0-17e3fcf133eb/events
session.orders.events(order_id, params)
```

## 7. Order Settings

The order settings resource is used to deal with various order-related configurations. It comprises the option to customize several notes on order documents such as `invoiceCancelationNote`, `defaultDeliveryDateNote`, and `defaultInvoiceNote`.

The fields related to orderNumberConfiguration and invoiceNumberConfiguration allow to control the structure of order and invoice numbers. A prefix can be defined for the respective number as well as a numeric suffix to start counting from. The length of the numeric suffix can also be configured.

A configuration such as

string prefix = `2017-shop-`

next numeric suffix = `1000`

numeric suffix length = `5`

results in `2017-shop-01000`, where the numeric suffix is increased for every order/invoice.

#### 7.1. ✅ List order settings 🌞

A `GET` request is used to retrieve the order settings.

```ruby
# GET /order-settings
session.order_settings.all
```

#### 7.2. ✅ Update order settings 🌞

A `PUT` request is used to update the order settings.

```ruby
# PUT /order-settings
session.order_settings.update(body)
```

## 8. Payment Methods

The `payment method` resources are used to get information about the payment methods of a shop. Payment methods refer to the options provided to a merchant’s customer at checkout, e.g. the option to pay with a credit card or via PayPal.

#### 8.1. ✅ Show payment method details 🌞

A `GET` request is used to retrieve the details of a payment method.

```ruby
# GET /payment-methods/864349cf-03ad-4b34-ba48-9ec24dd16e1e
session.payment_methods.find(payment_method_id)
```

#### 8.2. ✅ List payment methods 🌞

A `GET` request is used to list all payment methods in a paged way.

```ruby
# GET /payment-methods
session.payment_methods.all(params = {})
```

#### 8.3. ✅ Update payment method 🌞

A `PUT` request is used to update a payment method.

```ruby
# PUT /payment-methods/870e75d8-d25c-48d2-a9d1-164790753281
session.payment_methods.update(payment_method_id, body)
```

#### 8.4. ✅ Sort payment methods 🌞

A `PUT` request is used to sort payment methods.

```ruby
# PUT /payment-methods
session.payment_methods.sort([payment_method_ids])
```

#### 8.5. ✅ Activate a payment method 🌞

A `POST` request is used to activate a payment method.

```ruby
# POST /payment-methods/f882d4ed-d0f9-4bcb-9132-ff1704c601b0/activate
session.payment_methods.activate(payment_method_id)
```

#### 8.6. ✅ Deactivate a payment method 🌞

A `POST` request is used to deactivate a payment method.

```ruby
# POST /payment-methods/113a5ebf-294a-4c4a-b31e-dac3a8f0aa6d/deactivate
session.payment_methods.deactivate(payment_method_id)
```

## 9. Products

The `products` resource is used to manage products of a shop.

#### 9.1. List products including variation products 🌞

A `GET` request will list all of the products in a paged manner. The returned data is an excerpt projection, which includes a small subset of product properties.

```ruby
# GET /products
session.products.all(params = {})
```

#### 9.2. Create product 🌞

A `POST` request is used to create a product.

```ruby
# POST /products
session.products.create(body)
```

#### 9.3. Create variation product 🌞

A `POST` request is used to create a variation product and all its variations.

```ruby
# POST /products
session.products.create(body)
```

#### 9.4. Show product details 🌞

A `GET` request is used to retrieve the details of a product.

```ruby
# GET /products/70c989d6-f2f6-4fe1-809b-17ef19242265
session.products.find(product_id)
```

#### 9.5. Show variation product details 🌞

A `GET` request is used to retrieve the details of a variation product.

```ruby
# GET /products/d1f1e686-d8a1-4cec-b5a8-2355628521f8
session.products.find(product_id)
```

#### 9.6. ⛔ Update product partially (json patch)

A `PATCH` request is used to update a product partially with json patch content type.

```ruby
# PATCH /products/4dd2ea16-28aa-4715-9043-26dc0431afae
```

#### 9.7. Update product partially (json) 🌞

A `PATCH` request is used to update a product partially with json content type.

```ruby
# PATCH /products/7cbadace-b464-4832-acd5-c51bece4dae0
session.products.update(product_id, body)
```

#### 9.8. Update variation product partially (json) 🌞

A `PATCH` request is used to update a variation product with all its variations partially with json content type.

`variationAttributes` can not be updated at the moment!

```ruby
# PATCH /products/cfe3d847-18ef-4e64-9a53-35a2cce9b10f
session.products.update(product_id, body)
```

#### 9.9. Delete product 🌞

A `DELETE` request is used to delete a product or variation product. When a variation product is deleted, all its variations are deleted as well.

```ruby
# DELETE /products/05e754d8-cd2f-431a-b943-edcaaf60aa70
session.products.delete(product_id)
```

## 10. Product-related searches

A search resource is used as an entry point for links to sub-resources offering dedicated product-related searches. Currently the following search options are offered:

Search by SKU (10.1 - http://docs.beyondshop.cloud/#products-search-findBySku)

Find used tags starting with a string (10.2 - http://docs.beyondshop.cloud/#find-tags-starts-with)

#### 10.1. Find a product by SKU 🌞

A `GET` request is used to search for a product by SKU.

```ruby
# GET /products/search/find-by-sku?sku=vino020
session.products.search_by_sku(sku)
```

#### 10.2. Find used tags 🌞

A `GET` request is used to search used tags by a starting string. All strings are sorted by usage, starting with the biggest.

```ruby
# GET /products/search/tags?startsWith=aw
session.products.search_used_tags(starts_with, params)
```

#### 10.3. List product search meta-information

A `GET` request will list the product meta information.

```ruby
# GET /products/search
```

#### 10.4. Show product details 🌞

A `GET` request is used to retrieve the details of a product.

```ruby
# GET /product-view/products/e3e86c45-de19-4179-87a4-f5f7756a0294
session.product_view_products.find(product_id)
```

#### 10.5. Show variation product details 🌞

A `GET` request is used to retrieve the details of a variation product.

```ruby
# GET /product-view/products/2daa8462-8a8b-4dc9-b399-cf4b68088da8
session.product_view_products.find(product_id)
```

#### 10.6. Show variation details 🌞

A `GET` request is used to retrieve the details of a variation.

```ruby
# GET /product-view/products/e2caae78-d850-43aa-99c1-a33f66b64d12
session.product_view_products.find(product_id)
```

#### 10.7. List products 🌞

A `GET` request is used to list all products.

```ruby
# GET /product-view/products
session.product_view_products.all(params = {})
```

#### 10.8. List products by tags 🌞

A `GET` request is used to search for products matching any tag of the list given by a client. The intention is to offer product search capabilities for a shop’s storefront.

```ruby
# GET /product-view/products/search/find-by-tags?tag=number0
session.product_view_products.search_by_tag(tag, params)
```

#### 10.9. List available tags 🌞

A `GET` request is used to list all available tags.

```ruby
# GET /product-view/products/search/find-available-tags
session.product_view_products.search_available_tags
```

#### 10.10. List products by term 🌞

A `GET` request is used to search for products using a search query.

```ruby
# GET /product-view/products/search/find-by-search-term?query=search+snippet
session.product_view_products.search_by_term(term, params)
```

#### 10.11. ⚠️ List products by query 🌞

A `POST` request is used to search for products using a query provided as request body.

```ruby
# POST /product-view/products/search/find-by-query
session.product_view_products.search_by_query(query)
```

## 11. Variations

A `GET` request is used to retrieve the variation of a product.

#### 11.1. Show variation details 🌞

A `GET` request is used to retrieve the variation of a product.

```ruby
# GET /products/8ac7e72c-813b-472e-a37b-dba754e556c7/variations/a0ffb133-33dd-49c1-b4b6-3595fb9f5171
session.products_variations.find(product_id, variation_id)
```

#### 11.2. Update variation partially (json) 🌞

A `PATCH` request is used to update a variation partially with json content type.

```ruby
# PATCH /products/6f15d86b-26e8-4664-8694-650da181264d/variations/8e763dca-7490-4285-8fe2-1309e05b96b7
session.products_variations.update(product_id, variation_id, body)
```

#### 11.3. List variations 🌞

A `GET` request is used to retrieve the variations of a product.

```ruby
# GET /products/36e920c1-0b82-4096-8bca-0dd833e1e896/variations
session.products_variations.all(params = {})
```

## 12. Variation Properties

The `variation-properties` resource is used to manage the product (9 - http://docs.beyondshop.cloud/#_products) properties that can be customized for the respective variations. These resources also handle the current state of customization for each property, i.e. if a property is currently customized or not.

#### 12.1. List variation properties 🌞

A `GET` request is used to retrieve the variation properties of a variation product.

```ruby
# GET /products/a62f3c21-2b8b-432d-bda9-32b3d658afe9/variation-properties
session.products_variations.all_variation_properties
```

#### 12.2. Update variation properties 🌞

A `PATCH` request is used to update the variation properties of a variation product.

```ruby
# PATCH /products/e01a8142-a14d-4b58-b636-8e059bd3f73a/variation-properties
session.products.update_variation_properties(product_id, body)
```

## 13. Variation Product Availability

#### 13.1. Show variation availability details 🌞

A `GET` request is used to retrieve the availability of a variation.

```ruby
# GET /products/272aa543-ef8c-4324-865f-c0fe2a156c54/variations/09700077-b5e6-445d-a3d4-da7b518a3117/availability
session.variation_products.availability(product_id, variation_id)
```

#### 13.2. Enable purchasability for variation 🌞

A `POST` request is used to enable purchasability for a variation.

```ruby
# POST /products/a3a3f208-6173-408d-9184-e44eb2b228c6/variations/6fe13789-3c3a-4ef6-9140-03bd3965e0e5/availability/enable-purchasability
session.variation_products.enable_purchasability(product_id, variation_id)
```

#### 13.3. Disable purchasability for variation 🌞

A `POST` request is used to disable purchasability for a product.

```ruby
# POST /products/36c2920a-514f-4f7f-a829-19e02c7073bd/variations/9b3808f8-8f71-4c2b-bbf8-28e71fa59346/availability/disable-purchasability
session.variation_products.disable_purchasability(product_id, variation_id)
```

#### 13.4. Adjust stock level of variation 🌞

A `POST` request is used to adjust the available stock of a variation.

```ruby
# POST /products/13b8a219-3655-4b18-b590-468b7a88bb63/variations/a5d4e5a2-8b85-45e4-9d42-3c851e9e7bfd/availability/adjust-available-stock
session.variation_products.adjust_stock_level(product_id, variation_id, body)
```

## 14. Product Attachments

Product attachments represent files that come with a product, such as user manuals, product descriptions, or assembly instructions.

#### 14.1. ✅ List product attachments 🌞

A `GET` request is used to list all the attachments of a product.

```ruby
# GET /products/8aef9c43-00d1-43df-9249-c6292353918c/attachments
session.products.attachments(product_id, params)
```

#### 14.2. ✅ Show product attachment details 🌞

A `GET` request is used to retrieve a single attachment of a product.

```ruby
# GET /products/215408d3-1fdb-4039-a88b-877963e0395f/attachments/fd6f043a-a8ec-4766-b5b7-559f27979282
session.products.attachment(product_id, attachment_id)
```

#### 14.3. ✅ Add product attachment 🌞

A `POST` request is used to create an attachment and add it to a product.

```ruby
# POST /products/d1cf3c4f-3106-4b0c-84cd-76277a19c2b5/attachments
session.products.add_attachment(product_id, body)
```

#### 14.4. ✅ Delete product attachment 🌞

A `DELETE` request is used to delete a product attribute definition.

```ruby
# DELETE /products/2915ccf9-1593-4704-b9c9-fc5902bdd456/attachments/9da7cc9a-d43c-42cd-b0a1-71937ee78f71
session.products.delete_attachment(product_id, attachment_id)
```

## 15. Product Attribute Definitions

Attribute definitions provide meta data for attributes. An attribute definition is a precondition to create product attributes. (17.1 - http://docs.beyondshop.cloud/#resources-attributes)


#### 15.1. List product attribute definitions 🌞

A `GET` request will list the available product attribute definitions.

```ruby
# GET /product-attribute-definitions
session.product_attribute_definitions.all(params = {})
```

#### 15.2. Show product attribute definition details 🌞

A `GET` request is used to retrieve a single product attribute definition by name.

```ruby
# GET /product-attribute-definitions/filling_capacity
session.product_attribute_definitions.find(product_attribute_name)
```

#### 15.3. Create product attribute definition 🌞

A `POST` request is used to create a product attribute definition.

```ruby
# POST /product-attribute-definitions
session.product_attribute_definitions.create(body)
```

#### 15.4. Delete product attribute definition 🌞

A `DELETE` request is used to delete a product attribute definition.

```ruby
# DELETE /product-attribute-definitions/colour
session.product_attribute_definitions.delete(product_attribute_name)
```

## 16. Product Availability

#### 16.1. Show product availability details  🌞

A `GET` request is used to retrieve the availability of a product.

```ruby
# GET /products/129c3411-38a6-4f30-9b8a-6c0457db87bd/availability
session.products.availability(product_id)
```

#### 16.2. Enable stock management 🌞

A `POST` request is used to enable stock management for a product or variation product.

```ruby
# POST /products/fa69c896-1c1e-4103-8acf-4ecc29c66025/availability/enable-stock-management
session.products.enable_stock_management(product_id, body)
```

#### 16.3. Disable stock management 🌞

A `POST` request is used to disable stock management for a product or variation product.

```ruby
# POST /products/c8974f6d-2500-410e-a369-b1aa56f5a825/availability/disable-stock-management
session.products.disable_stock_management(product_id)
```

#### 16.4. Adjust stock level 🌞

A `POST` request is used to adjust the available stock of a product.

```ruby
# POST /products/96821431-0efe-444c-afd1-2de16723f830/availability/adjust-available-stock
session.products.adjust_stock_level(product_id, body)
```

#### 16.5. Update reserve stock 🌞

Reserve stock refers to an inventory level that indicates that a product needs to be reordered. A `POST` request is used to update this reserve stock by changing the `stockThreshold` value of a product or variation product (incl. all of its variations).

```ruby
# POST /products/48277de8-9866-4eb8-8eb5-bcff85dc2124/availability/update-stock-threshold
session.products.update_reserve_stock(product_id, body)
```

#### 16.6. Enable purchasability 🌞

A `POST` request is used to enable purchasability for a product.

```ruby
# POST /products/e00ac1c3-7431-4379-b5f3-c990d2095bdd/availability/enable-purchasability
session.products.enable_purchasability(product_id)
```

#### 16.7. Disable purchasability 🌞

A `POST` request is used to disable purchasability for a product.

```ruby
# POST /products/cf4cb507-1e47-4cbc-927f-7d7d9f86695e/availability/disable-purchasability
session.products.disable_purchasability(product_id)
```

## 17. Custom Product Attributes

The `attributes` resource is used to manage additional user-defined attributes which have a product attribute definition as key, and a string or number as value. These are the basic attribute types supported by the Api.

| Type  | Description  |
|---|---|
| STRING  | String value (max. 4 kb)  |
| NUMBER  | Double-precision floating number  |

#### 17.1. Create product attribute 🌞

A `POST` request is used to create a product attribute, which defines the value of a certain (15.1 - http://docs.beyondshop.cloud/#resources-product-attribute-definitions) product attribute definition for a specific product (9.1 - http://docs.beyondshop.cloud/#resources-products).

```ruby
# POST /products/fe9e4875-1123-4227-bede-2456033f169a/attributes
session.products.create_custom_attribute(product_id, body)
```

#### 17.2. Retrieve product attribute 🌞

A `GET` request is used to retrieve detailed information about a specific product attribute.

```ruby
# GET /products/fe9e4875-1123-4227-bede-2456033f169a/attributes/key
session.products.find_custom_attribute(product_id, attribute_name)
```

#### 17.3. List product attributes 🌞

A `GET` request is used to retrieve all product attributes for a product.

```ruby
# GET /products/fe9e4875-1123-4227-bede-2456033f169a/attributes
session.products.custom_attributes(product_id, params)
```

#### 17.4. Update product attribute 🌞

A `PUT` request is used to update the value of a product attribute. If the specified product attribute doesn’t exist, it will be created with the response as described in Create product attribute. (17.1 http://docs.beyondshop.cloud/#resources-product-attribute-create)

```ruby
# PUT /products/40432a7e-d3c6-43a2-a817-9483e39d39b8/attributes/key
session.products.update_custom_attribute(product_id, attribute_name, body)
```

#### 17.5. Delete product attribute 🌞

A `DELETE` request is used to delete a product attribute.

```ruby
# DELETE /products/f9a812d2-a244-4a8a-90c0-781eb184d4d2/attributes/farbe
session.products.delete_custom_attribute(product_id, attribute_name)
```

## 18. Product Images

#### 18.1. List product images   🌞

A `GET` request is used to retrieve the images of a product.

```ruby
# GET /products/191c5881-f00c-4c49-b418-9e037209b2ef/images
session.products.images(params = {})
```

#### 18.2. Show product image details 🌞

A `GET` request is used to retrieve a single image of a product.

```ruby
# GET /products/4c55e496-7495-422b-bd10-741aa224452a/images/8d64d841-23b9-480c-b12a-4ace9974eaf4
session.products.image(product_id, image_id)
```

#### 18.3. Add product image 🌞

A `POST` request is used to create an image and add it to a product.

```ruby
# POST /products/f856ac14-40b8-4b13-b9c0-e45d632cb02d/images
session.products.set_image_as_default(product_id, image_id)
```

#### 18.4. Upload product image 🌞

A `POST` request is used to upload an image and add it to a product. The body of the request must contain the content of the image.

```ruby
# POST /products/4125b993-49fc-47c8-b9b3-76d8871e4e06/images?fileName=file.png'
session.products.upload_image(product_id, image_path, image_name)
```

#### 18.5. Delete product image 🌞

A `DELETE` request is used to delete a product image.

```ruby
# DELETE /products/2f43e3d0-6e40-4312-a36b-59385229db38/images/0b9e823d-6674-4b90-bcf8-f7d10e137e6b
session.products.delete_image(product_id, image_id)
```

#### 18.6. Assign product image as default image 🌞

A `PUT` request is used to assign a product image as the default image. The request contains a single URI of the image to assign.

```ruby
# PUT /products/2fe409d3-2bfa-4d69-975b-d07114ac76a4/default-image
session.products.set_default_image(product_id, body)
```

## 19. Product Settings

The `product-settings` resource is used to manage product related settings.

#### 19.1. ✅ Show product settings

A `GET` request is used to retrieve the product settings.

```ruby
# GET /product-settings
session.product_settings.all 🌞
```

#### 19.2. ⛔ Update product settings (json patch)

A `PATCH` request is issued to update the product settings partially with json patch content type.

```ruby
# PATCH /product-settings
session.product_settings.update(json_patch)
```

## 20. Scopes

#### 20.1. ✅ List scopes 🌞

A `GET` request will list all scopes in the system.

```ruby
# GET /scopes
session.scopes.all(params = {})
```

## 21. Script tags

#### 21.1. ✅ Create script tag 🌞

A `POST` request is used to create a script tag.

```ruby
# POST /script-tags
session.script_tags.create(script_tag_url)
```

#### 21.2. ✅ Show script tag details 🌞

A `GET` request is used to retrieve a single script tag.

```ruby
# GET /script-tags/353dbeae-d23d-4fec-95ab-33cbea8ca0e0
session.script_tags.find(script_tag_id)
```

#### 21.3. ✅ List script tags 🌞

A `GET` request is used to retrieve a list of all script tags for a shop.

```ruby
# GET /script-tags
session.scrip_tags.all(params = {})
```

#### 21.4. ✅ Update script tag 🌞

A `PUT` request is used to update an existing script tag. You can only update a script tag created by your app.

```ruby
# PUT /script-tags/4508f002-9188-4584-811c-9514162d13be
session.script_tags.update(script_tag_id, script_tag_url)
```

#### 21.5. ✅ Delete script tag 🌞

A `DELETE` request is used to delete a script tag. You can only delete a script tag created by your app.

```ruby
# DELETE /script-tags/70d00526-4a9d-4d49-8abd-59d38c29d937
session.script_tags.delete(script_tag_id)
```

## 22. Shipping Methods

The `cart shipping method` resources hold information on the shipping methods handled for a cart.

#### 22.1. ✅ Set current cart shipping method 🌞

A `PUT` request is used to set the current shipping method of the cart.

```ruby
# PUT /carts/ba8ec1c7-dce1-41e9-8daf-5f03b9b96f42/shipping-methods/current
session.carts.set_shipping_method(cart_id, shipping_zone_id, shipping_method_id)
```

#### 22.2. ✅ Set cart shipping method to current default 🌞

A `PUT` request is used to set the shipping method to the current default shipping method. The default shipping method is the one with the highest priority of the applicable shipping methods.

```ruby
# PUT /carts/e70d6b6d-d35f-4bcb-b3bd-0c4e206c9aa1/shipping-methods/default
session.carts.set_shipping_method_to_default(cart_id)
```

#### 22.3. ✅ Show current cart shipping method details 🌞

A `GET` request is used to get the current shipping method. The shipping method type is documented here. (http://docs.beyondshop.cloud/#resources-shipping-method-get)

```ruby
# GET /carts/3be82060-7a2e-410b-82c3-367d48fb0af9/shipping-methods/current
session.carts.shipping_method(cart_id)
```

#### 22.4. ✅ Show applicable cart shipping method details 🌞

A `GET` request is used to get the applicable shipping methods of a cart. The shipping method type is documented here

The `selectable` field indicates if a shipping method is currently selectable. Non-selectable shipping methods are currently restricted because of rules that apply to a cart. Trying to set such a shipping method as the current one of the cart will fail.

```ruby
# GET /carts/afee990d-0ff6-4586-b918-a56cb3157efd/shipping-methods
session.carts.shipping_methods(cart_id)
```

## 23. Shipping Zones

The `shipping zone` resources are used to get information about the shipping zones of a shop. Shipping zones hold shipping methods that are applicable inside a shipping zone.

#### 23.1. ✅ Show shipping zone details 🌞

A `GET` request is used to retrieve the details of a shipping zone.

```ruby
# GET /shipping-zones/74d0c669-9469-41b1-9a4e-66e55185eb90
session.shipping_zones.find(shipping_zone_id)
```

#### 23.2. ✅ Create shipping zone 🌞

A `POST` request is used to create a shipping zone.

```ruby
# POST /shipping-zones
session.shipping_zones.create(body)
```

#### 23.3. ✅ Update shipping zone 🌞

A `PUT` request is used to update a shipping zone.

```ruby
# PUT /shipping-zones/6f2b3c57-966c-4f17-aec4-2a397e6ecd87
session.shipping_zones.update(shipping_zone_id, body)
```

#### 23.4. ✅ Delete shipping zone 🌞

A `DELETE` request is used to delete a shipping zone. You cannot delete the shipping zone if it contains the last shipping method of a shop.

```ruby
# DELETE /shipping-zones/77556e23-9e35-471f-a5d6-69617e50ca1d
session.shipping_zones.delete(shipping_zone_id)
```

#### 23.5. ✅ List shipping zones 🌞

A `GET` request is used to list all shipping zones in a paged way.

```ruby
# GET /shipping-zones
session.shipping_zones.all(params = {})
```

#### 23.6. ✅ Sort shipping zones 🌞

A `PUT` request is used to sort the shipping zones. This is done by passing the self-links of the shipping zones in the desired order. The request must contain URIs for all shipping zones of the given page.

```ruby
# PUT /shipping-zones
session.shipping_zones.sort(shipping_zone_ids)
```

#### 23.7. ✅ Show details of shipping method in shipping zone 🌞

A `GET` request is used to retrieve the details of a shipping method in a shipping zone.

```ruby
# GET /shipping-zones/4ed24adb-d6f5-49f5-9da4-fb53664e90c3/shipping-methods/4509a835-9a60-4a9f-b078-29ee591b99a2
session.shipping_zones.shipping_method(shipping_zone_id, shipping_method_id)
```

#### 23.8. ✅ Show details of shipping method with weight-based price in shipping zone 🌞

A `GET` request is used to retrieve the details of a shipping method with weight-based price in a shipping zone.

```ruby
# GET /shipping-zones/28736658-a87b-403e-a45b-82ac6699862d/shipping-methods/16159608-54fc-43ef-81fb-39661342e5db
session.shipping_zones.shipping_method(shipping_zone_id, shipping_method_id)
```

#### 23.9. ✅ Create shipping method in shipping zone 🌞

A `POST` request is used to create a shipping method in a shipping zone.

```ruby
# POST /shipping-zones/9ff15c7b-70c2-42de-a900-7a924ae0e4a0/shipping-methods
session.shipping_zones.create_shipping_method(shipping_zone_id, body)
```

#### 23.10. ✅ Create shipping method with weight-based price in shipping zone 🌞

A `POST` request is used to create a shipping method with weight-based price in a shipping zone.

```ruby
# POST /shipping-zones/0fcdd0f6-20df-4b09-a871-7568b64e11f1/shipping-methods
session.shipping_zones.create_shipping_method(shipping_zone_id, body)
```

#### 23.11. ✅ Delete shipping method in shipping zone 🌞

A `DELETE` request is used to delete a shipping method in a shipping zone. You cannot delete the last shipping method of a shop.

```ruby
# DELETE /shipping-zones/4c56db2a-aadd-4a9f-94a3-ff2520e29de1/shipping-methods/099045dd-bafb-4cdb-89bd-28a475ab3468
session.shipping_zones.delete_shipping_method(shipping_zone_id, shipping_method_id)
```

#### 23.12. List shipping methods of shipping zone 🌞

A `GET` request is used to list all shipping-methods of a shipping zone in a paged way.

```ruby
# GET /shipping-zones/2157566e-232b-4f64-ba21-da3d4e8696b6/shipping-methods
session.shipping_zones.shipping_methods(shipping_zone_id, params)
```

#### 23.13. Sort shipping methods in shipping zone 🌞

A `PUT` request is used to sort the shipping methods inside a shipping zone. This is done by passing the self-links of the shipping methods in the desired order. The request must contain URIs for all shipping methods of this shipping zone.

```ruby
# GET /shipping-zones/f943aef9-e74b-4f85-ae7b-cf6413293715/shipping-methods
session.shipping_zones.sort_shipping_methods(shipping_zone_id)
```

#### 23.14. Find serviceable countries 🌞

A `GET` request is used to find the serviceable countries.

```ruby
# GET /shipping-zones/search/find-all-serviceable-countries
session.shipping_zones.find_serviceable_countries
```

## 24. Shop

This resource represents the requests to manage the merchant’s shop address.

#### 24.1. ✅ Show address details 🌞

A `GET` request is used to retrieve the details of a shop’s address.

```ruby
# GET /shop/address
session.shop.address
```

#### 24.2. ⛔ Update address partially (json patch)

A `PATCH` request is used to update a shop’s address partially with json patch content type.

```ruby
# PATCH /shop/address
```

#### 24.3. ✅ Update address partially (json) 🌞

A `PATCH` request is used to patch a shop’s address partially with json content type.

```ruby
# PATCH /shop/address
session.shop.update_address(body)
```

#### 24.4. ✅ Create shop attribute 🌞

A `POST` request is used to create a shop attribute.

```ruby
# POST /shop/attributes
session.shop.create_attribute(body)
```

#### 24.5. ✅ Show shop attribute details 🌞

A `GET` request is used to retrieve a particular shop attribute by its name.

```ruby
# GET /shop/attributes/second-unknown-attribute-name
session.shop.attribute(attribute_name)
```

#### 24.6. ✅ List shop attributes 🌞

A `GET` request is used to retrieve a list of all shop attributes.

```ruby
# GET /shop/attributes
session.shop.attributes(params = {})
```

#### 24.7. ✅ Update shop attribute 🌞

A `PUT` request is used to update a shop attribute. This operation is idempotent and will create a new shop attribute if required.

```ruby
# PUT /shop/attributes/second-unknown-attribute-name
session.shop.update_attribute(attribute_name, body)
```

#### 24.8. ✅ Delete shop attribute 🌞

A `DELETE` request is used to delete an shop attribute.

```ruby
# DELETE /shop/attributes/second-unknown-attribute-name
session.shop.delete_attribute(attribute_name)
```

#### 24.9. ✅ List shop images 🌞

A `GET` request is used to retrieve the images of a shop.

```ruby
# GET /shop/images
session.shop.images(params = {})
```

#### 24.10. ✅ Show shop image details 🌞

A `GET` request is used to retrieve a single shop image.

```ruby
# GET /shop/images/06d6aca3-fbba-42fc-b9b2-aee305e74842
session.shop.image(image_id)
```

#### 24.11. ✅ Create shop image 🌞

A `POST` request is used to create a shop image.

```ruby
# POST /shop/images
session.shop.create_image(body)
```

#### 24.12. ✅ Delete shop image 🌞

A `DELETE` request is used to delete a shop image.

```ruby
# DELETE /shop/images/924d7ee7-b4fd-4782-bc71-309b0d02e0a2
session.shop.delete_image(image_id)
```

#### 24.13. ✅ Find shop images by label 🌞

A `GET` request is issued to search for shop images by label.

```ruby
# GET /shop/images/search/find-by-label?label=logo
session.shop.search_images_by_label(label)
```

#### 24.14. ✅ Upload shop image 🌞

A `POST` request is used to upload a shop image. The body of the request must contain the content of the image.

```ruby
# POST /shop/images?fileName=sample.png&label=invoice logo
session.shop.upload_image(image_binary, file_name, label)
```

#### 24.15. ✅ Show legal details 🌞

A `GET` request is used to retrieve the details of the legal resource.

```ruby
# GET /shop/legal
session.shop.legal_details
```

#### 24.16. ⛔ Update legal resource partially (json patch)

A `PATCH` request is used to update a legal resource partially with json patch content type.

```ruby
# PATCH /shop/legal
```

#### 24.17. ✅ Update legal resource partially (json) 🌞

A `PATCH` request is used to update a legal resource partially with json content type.

```ruby
# PATCH /shop/legal
session.shop.update_legal_content(body)
```

#### 24.18. ✅ List legal content 🌞

A `GET` request is used to retrieve the legal content of a shop.

```ruby
# GET /legal-content
session.shop.legal_contents(params = {})
```

#### 24.19. ✅ Show legal content details 🌞

A `GET` request is used to retrieve a specific part of the legal content information.

```ruby
# GET /legal-content/right-of-withdrawal
session.shop.legal_content(legal_content_type)
```

#### 24.20. ✅ Update legal content 🌞

A `PUT` request is used to update the content of a specific part of the legal content information. Changes on the properties type and mandatory will be ignored.

```ruby
# PUT /legal-content/legal-notice
session.shop.update_legal_content(body)
```

#### 24.21. ✅ Show shop details 🌞

A `GET` request is used to retrieve the details of a shop.

```ruby
# GET /shop
session.shop.current
```

#### 24.22. ✅ Update shop 🌞

A `PUT` request is used to change attributes of a shop.

```ruby
# PATCH /shop
session.shop.update(body)
```

#### 24.23. ⛔ Update shop partially (json patch)

A `PATCH` request is used to partially update a shop resource with json patch content type.

```ruby
# PATCH /shop
```

#### 24.24. ✅ Open shop 🌞

A `POST` request is used to open a shop.

```ruby
# POST /shop/open
session.shop.open
```

#### 24.25. ✅ Close shop 🌞

A `POST` request is used to close a shop.

```ruby
# POST /shop/close
session.shop.close
```

## 25. Users

A user is referred to as a merchant of a beyondshop.

#### 25.1. ✅ List users 🌞

A `GET` request is used to list all users visible to the current user. This request will not list the support user.

```ruby
# GET /users
session.users.all(params = {})
```

#### 25.2. ✅ Show user details 🌞

A `GET` request is used to retrieve the details of a user.

```ruby
# GET /users/04b293c4-4cd7-41f9-a20a-2ad6753ccfc7
session.users.find(user_id)
```

#### 25.3. ✅ Create user 🌞

A `POST` request is used to create a user.

```ruby
# POST /users
session.users.create(body)
```

#### 25.4. ✅ List user roles 🌞

A `GET` request is used to list all roles of a user.

```ruby
# GET /users/dc3e4f0e-5112-4d3f-8ce4-9f920594a5e3/roles
session.users.roles(user_id)
```

#### 25.5. Set user roles 🌞

A `PUT` request is used set the roles of a user.

```ruby
# PUT /users/439ac4c9-4102-4ee2-bb91-dc2cde0f7a4b/roles
session.users.set_roles(user_id, body)
```

#### 25.6. Add user roles 🌞

A `POST` request is used to add the roles of a user.

```ruby
# POST /users/361caa25-e184-434c-8774-2287fe3ef06a/roles
session.users.add_roles(user_id, body)
```

#### 25.7. ⛔ List user searches 🌞

A `GET` request is used to provide an overview of the search endpoints the user resource offers.

```ruby
# GET /users/search
session.users.list_searches
```

#### 25.8. ✅ Find user by username 🌞

A `GET` request is used to find a user by username.

```ruby
# GET /users/search/find-by-username?username=username
session.users.search_by_username(username)
```

#### 25.9. ✅ Verify password 🌞

A `POST` request is used to verify a password against the password guidelines.

```ruby
# POST /users/verify-password
session.users.verify_password(password)
```

#### 25.10. ✅ Change password 🌞

A `POST` request is used to change the password of a user.

```ruby
# POST /users/968e449b-3467-483f-a9e0-458a709ce2b8/change-password
session.users.change_password(user_id, current_password, new_password)
```

#### 25.11. ✅ Trigger password reset email 🌞

A `POST` request is used to trigger a password reset email to be sent to a user. The email will contain a link to the change password settings page of the merchant’s cockpit. The link includes a JWT to authorize the password reset.

```ruby
# POST /users/reset-password-request?locale=en-US
session.users.send_reset_password_email(email, locale)
```

#### 25.12. ✅ Change username 🌞

A `POST` request is used to change the username of a user.

```ruby
# POST /users/b1f12e35-fd8b-47c5-a28e-d2bf19d73da5/change-username
session.users.change_username(user_id, current_username, new_username)
```

#### 25.13. ✅ Retrieve support access status 🌞

A `GET` request is used to retrieve the status of the support access for a shop, i.e. if the support user is enabled or disabled for the shop.

```ruby
# GET /users/support
session.users.support_access
```

#### 25.14. ✅ Enable support access 🌞

A `POST` request is used to enable support access for a shop. If enabled, the customer support will receive specific rights for direct support in the merchant’s cockpit.

```ruby
# POST /users/support
session.users.enable_support_access
```

#### 25.15. ✅ Disable support access 🌞

A `POST` request is used to disable support access.

```ruby
# DELETE /users/support
session.users.disable_support_access
```

#### 25.16. ✅ Trigger email address change 🌞

A `POST` request is used to trigger an email address change. A confirmation email to change the email address will be sent to the user. The confirmation email will contain a link to the email address change page of the merchant’s cockpit. The link includes a JWT to authorize the email address change.

```ruby
# POST /users/d214c55a-934d-4ab3-b7e8-9c910a6903ae/change-email-request?locale=en-US
session.users.send_email_address_change(user_id, email, current_password, locale)
```

## 26. Newsletter targets

#### 26.1. ✅ Create newsletter target 🌞

A `POST` request is used to create the newsletter target. Each shop can only have one newsletter target. You can update this target at any time, or delete the existing one and create a new target.

```ruby
# POST /newsletter-target
session.newsletter_target.create(submit_url)
```

#### 26.2. ✅ Get newsletter target details 🌞

A `GET` request is used to retrieve the newsletter target.

```ruby
# GET /newsletter-target
session.newsletter_target.find
```

#### 26.3. ✅ Update newsletter target 🌞

A `PUT` request is used to update the existing newsletter target.

```ruby
# PUT /newsletter-target
session.newsletter_target.update(body)
```

#### 26.4. ✅ Delete newsletter target 🌞

A `DELETE` request is used to delete the existing newsletter target.

```ruby
# DELETE /newsletter-target
session.newsletter_target.delete
```

## 27. Webhooks

This resource is used to manage webhook subscriptions. ePages can send webhook notifications to your application any time an event happens that you’ve subscribed to. Subscriptions are useful for events that are not triggered by a direct Api request. The following event types are supported:

| Event Type Name  | Description  | Required Scope  |
|---|---|---|
| order.created  | Triggered when an order is created.  | ordr:r  |
| order.updated  | Triggered when an order is updated.  | ordr:r  |
| order.deleted  | Triggered when an order is deleted.  | ordr:r  |
| product.created  | Triggered when a product is created.  | prod:r  |
| product.updated  | Triggered when a product is updated.  | prod:r  |
| product.deleted  | Triggered when a product is deleted.  | prod:r  |

#### 27.1. ✅ Create webhook subscription 🌞

A `POST` request is used to create a webhook subscription.

The scopes needed for the operation depend on the event types you register for. e.g. Order events require the scope `orde:r`.

```ruby
# POST /webhook-subscriptions
session.webhook_subscriptions.create(body)
```

#### 27.2. ✅ Show webhook subscription details 🌞

A `GET` request is used to retrieve the details of a webook subscription.

```ruby
# GET /webhook-subscriptions/df276020-27db-4877-84d1-80384cb985f0
session.webhook_subscriptions.find(webhook_subscription_id)
```

#### 27.3. ✅ Update webhook subscription 🌞

A `PUT` request is used to update a subscription.

The scopes needed for the operation depend on the event types you register for. e.g. Order events require the scope `orde:r`.

```ruby
# PUT /webhook-subscriptions/153c727f-56e1-4610-930e-82c3be7a0db5
session.webhook_subscriptions.update(webhook_subscription_id, body)
```

#### 27.4. ✅ List webhook subscriptions 🌞

A `GET` request is used to list all of the webhook subscriptions in a paged way.

```ruby
# GET /webhook-subscriptions
session.webhook_subscriptions.all(params = {})
```

#### 27.5. ✅ Delete webhook subscription 🌞

A `DELETE` request is used to delete a webhook subscription.

```ruby
# DELETE /webhook-subscriptions/9f5f777b-1149-4567-9b77-549bc9372c25
session.webhook_subscriptions.delete(webhook_subscription_id)
```

#### 27.6. ✅ Activate webhook subscription 🌞

A `POST` request is used to activate a webhook subscription.

```ruby
# POST /webhook-subscriptions/80c1c3a5-6c2f-4654-9a5e-ebf1245c3453/activate
session.webhook_subscriptions.activate(webhook_subscription_id)
```

#### 27.7. ✅ Deactivate webhook subscription 🌞

A `POST` request is used to deactivate a webhook subscription.

```ruby
# POST /webhook-subscriptions/2bab0805-9cf8-4705-a936-037cb0577e04/deactivate
session.webhook_subscriptions.deactivate(webhook_subscription_id)
```
