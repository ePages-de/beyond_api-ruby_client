# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Shop < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to retrieve the details of a shop’s address.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/address' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shad:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.address
    #
    def address
      response, status = BeyondAPI::Request.get(@session, "/shop/address")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a particular shop attribute by its name.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes/second-unknown-attribute-name' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shat:r+
    #
    # @param attribute_name [String] the attribute name
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shop_attribute = session.shop.attribute("second-unknown-attribute-name")
    #
    def attribute(attribute_name)
      response, status = BeyondAPI::Request.get(@session, "/shop/attributes/#{attribute_name}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a list of all shop attributes.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shat:r+
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @shop_attributes = session.shop.attributes(size: 5, page: 1)
    #
    def attributes(params)
      response, status = BeyondAPI::Request.get(@session, "/shop/attributes", params)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to close a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/close' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shcl:c+
    #
    # @return true
    #
    # @example
    #   session.shop.close
    #
    def close
      response, status = BeyondAPI::Request.post(@session, "/shop/close")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to create a shop attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "second-unknown-attribute-name",
    #     "value" : "correct-value",
    #     "public" : false
    #   }'
    #
    # @beyond_api.scopes +shat:c+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "second-unknown-attribute-name",
    #     "value" => "correct-value",
    #     "public" => false
    #   }
    #
    #   session.shop.create_attribute(body)
    #
    def create_attribute(body)
      response, status = BeyondAPI::Request.post(@session, "/shop/attributes", body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a shop image.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/images' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "dataUri" : "file.png?hash=212-2323-4343",
    #     "label" : "logo"
    #   }'
    #
    # @beyond_api.scopes +shim:c+
    #
    # @param body [Hash] the request body
    #
    # @return true
    #
    # @example
    #   body = {
    #     "dataUri" => "file.png?hash=212-2323-4343",
    #     "label" => "logo"
    #   }
    #
    #   session.shop.create_image(body)
    #
    def create_image(body)
      response, status = BeyondAPI::Request.post(@session, "/shop/images", body)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the details of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop' -i -X GET \
    #       -H 'Accept: application/hal+json'
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.current
    #
    def current
      response, status = BeyondAPI::Request.get(@session, "/shop")

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete an shop attribute.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes/second-unknown-attribute-name' -i -X DELETE \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shat:d+
    #
    # @param attribute_name [String] the attribute name
    #
    # @return true
    #
    # @example
    #   session.shop.delete_attribute("second-unknown-attribute-name")
    #
    def delete_attribute(attribute_name)
      response, status = BeyondAPI::Request.delete(@session, "/shop/attributes/#{attribute_name}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +DELETE+ request is used to delete a shop image.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/images/6a7646dc-7f26-4730-a98f-52f9b63978fb' -i -X DELETE \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shim:d+
    #
    # @param image_id [String] the image UUID
    #
    # @return true
    #
    # @example
    #   session.shop.delete_image("6a7646dc-7f26-4730-a98f-52f9b63978fb")
    #
    def delete_image(image_id)
      response, status = BeyondAPI::Request.delete(@session, "/shop/images/#{image_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve a single shop image.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/images/2feee7ac-f1cb-4faf-9488-f3ce07394141' -i -X GET \
    #       -H 'Accept: application/hal+json'
    #
    # @param image_id [String] the image UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.image("2feee7ac-f1cb-4faf-9488-f3ce07394141")
    #
    def image(image_id)
      response, status = BeyondAPI::Request.get(@session, "/shop/images/#{image_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the images of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/images' -i -X GET \
    #       -H 'Accept: application/hal+json'
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.images(size: 5, page: 1)
    #
    def images(params)
      response, status = BeyondAPI::Request.get(@session, "/shop/images", params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a specific part of the legal content information.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/legal-content/right-of-withdrawal' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json'
    #
    # @param legal_content_type [String] the legal content type
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.legal_content("right-of-withdrawal")
    #
    def legal_content(legal_content_type)
      response, status = BeyondAPI::Request.get(@session, "/legal-content/right-of-withdrawal")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the legal content of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/legal-content' -i -X GET \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json'
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.legal_contents(size: 5, page: 1)
    #
    def legal_contents(params)
      response, status = BeyondAPI::Request.get(@session, "/legal-content")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of the legal resource.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/legal' -i -X GET \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +legl:r+
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.legal_details
    #
    def legal_details
      response, status = BeyondAPI::Request.get(@session, "/shop/legal")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to open a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/open' -i -X POST \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shcl:c+
    #
    # @return true
    #
    # @example
    #   session.shop.open
    #
    def open
      response, status = BeyondAPI::Request.post(@session, "/shop/open")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is issued to search for shop images by label.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/images/search/find-by-label?label=logo' -i -X GET \
    #       -H 'Accept: application/hal+json'
    #
    # @param label [String] the image label
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.search_images_by_label("logo")
    #
    def search_images_by_label(label)
      response, status = BeyondAPI::Request.get(@session, "/shop/images/search/find-by-label", { label: label })

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to change attributes of a shop.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "name" : "anotherName",
    #     "closedShopMessage" : "This shop is opening soon.",
    #     "primaryHostname" : "cornershop.amazingdiscounts.xyz",
    #     "fallbackHostname" : "cornershop.beyondshop.cloud",
    #     "tax" : {
    #       "taxModel" : "GROSS",
    #       "vatExempted" : false
    #     },
    #     "currencies" : [ "EUR", "USD", "GBP" ],
    #     "defaultCurrency" : "USD",
    #     "locales" : [ "en-GB", "de-DE" ],
    #     "defaultLocale" : "en-GB",
    #     "closedByMerchant" : false
    #   }'
    #
    # @beyond_api.scopes +shop:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "name" => "anotherName",
    #     "closedShopMessage" => "This shop is opening soon.",
    #     "primaryHostname" => "cornershop.amazingdiscounts.xyz",
    #     "fallbackHostname" => "cornershop.beyondshop.cloud",
    #     "tax" => {
    #       "taxModel" => "GROSS",
    #       "vatExempted" => false
    #     },
    #     "currencies" => [ "EUR", "USD", "GBP" ],
    #     "defaultCurrency" => "USD",
    #     "locales" => [ "en-GB", "de-DE" ],
    #     "defaultLocale" => "en-GB",
    #     "closedByMerchant" => false
    #   }
    #
    #   session.shop.update(body)
    #
    def update(body)
      response, status = BeyondAPI::Request.patch(@session, "/shop")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to patch a shop’s address partially with json content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/address' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "city" : "Barcelona"
    #   }'
    #
    # @beyond_api.scopes +shad:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "city" => "Barcelona"
    #   }
    #
    #   session.shop.update_address(body)
    #
    def update_address(body)
      response, status = BeyondAPI::Request.patch(@session, "/shop/address", body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a shop attribute. This operation is idempotent and will create a new shop attribute if required.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/attributes/second-unknown-attribute-name' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "value" : "new-value",
    #     "public" : false
    #   }'
    #
    # @beyond_api.scopes +shat:u+
    #
    # @param attribute_name [String] the attribute name
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "value" => "new-value",
    #     "public" => false
    #   }
    #
    #   session.shop.update_attribute("second-unknown-attribute-name", body)
    #
    def update_attribute(attribute_name, body)
      response, status = BeyondAPI::Request.put(@session, "/shop/attributes/#{attribute_name}", body)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update the content of a specific part of the legal content information. Changes on the properties type and mandatory will be ignored.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/legal-content/legal-notice' -i -X PUT \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "content" : "new legal content"
    #   }'
    #
    # @beyond_api.scopes +lcnt:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.shop.update_legal_content(body)
    #
    def update_legal_content(body)
      response, status = BeyondAPI::Request.put(@session, "/legal-content/legal-notice")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to update a legal resource partially with json content type.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/shop/legal' -i -X PATCH \
    #       -H 'Content-Type: application/json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #     "vatId" : "GB 111111111"
    #   }'
    #
    # @beyond_api.scopes +legl:u+
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "vatId" => "GB 111111111"
    #   }
    #
    #   session.shop.update_legal_details(body)
    #
    def update_legal_details(body)
      response, status = BeyondAPI::Request.patch(@session, "/shop/legal")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to upload a shop image. The body of the request must contain the content of the image.
    #
    #   $ curl --data-binary '@/home/epages/sample.png' 'https://api-shop.beyondshop.cloud/api/shop/images?fileName=sample.png&label=invoice logo' -X POST \
    #       -H 'Content-Type: image/png' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +shim:c+
    #
    # @param image_path [String] the image path
    # @param image_name [String] the image name
    # @param label [String] the image label
    #
    # @return true
    #
    # @example
    #   session.shop.upload_image("/home/epages/sample.png", "sample.png", "invoice logo")
    #
    def upload_image(image_path, image_name, label)
      content_type = case File.extname(image_path)
        when ".png"
          "image/png"
        when ".jpg", ".jpeg"
          "image/jpeg"
        when ".gif"
          "image/gif"
        end
      image_binary = File.binread(image_path)

      response, status = BeyondAPI::Request.upload(@session, "/shop/images", image_binary, content_type, { file_name: image_name, label: label })

      handle_response(response, status, respond_with_true: true)
    end
  end
end
