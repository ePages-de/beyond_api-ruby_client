# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Shop < Base
    include BeyondAPI::Utils

    #
    # A +GET+ request is used to retrieve the details of a shop’s address.
    #
    # @scopes +shad:r+
    #
    # @example
    #   session.shop.address
    def address
      response, status = BeyondAPI::Request.get(@session, "/shop/address")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to patch a shop’s address partially with json content type.
    #
    # @scopes +shad:u+
    #
    # @example
    #   session.shop.update_address(body)
    def update_address(body)
      response, status = BeyondAPI::Request.patch(@session, "/shop/address", body)

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a shop attribute.
    #
    # @scopes +shat:c+
    #
    # @example
    #   session.shop.create_attribute(body)
    def create_attribute(body)
      response, status = BeyondAPI::Request.post(@session, "/shop/attributes", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a particular shop attribute by its name.
    #
    # @scopes +shat:r+
    #
    # @example
    #   session.shop.attribute(attribute_name)
    def attribute(attribute_name)
      response, status = BeyondAPI::Request.get(@session, "/shop/attributes/second-unknown-attribute-name", attribute_name)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a list of all shop attributes.
    #
    # @scopes +shat:r+
    #
    # @example
    #   session.shop.attributes(params)
    def attributes(params)
      response, status = BeyondAPI::Request.get(@session, "/shop/attributes", params)

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update a shop attribute. This operation is idempotent and will create a new shop attribute if required.
    #
    # @scopes +shat:u+
    #
    # @example
    #   session.shop.update_attribute(attribute_name, body)
    def update_attribute(attribute_name, body)
      response, status = BeyondAPI::Request.put(@session, "/shop/attributes/#{attribute_name}", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete an shop attribute.
    #
    # @scopes +shat:d+
    #
    # @example
    #   session.shop.delete_attribute(attribute_name)
    def delete_attribute(attribute_name)
      response, status = BeyondAPI::Request.delete(@session, "/shop/attributes/#{attribute_name}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the images of a shop.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.images(params)
    def images(params)
      response, status = BeyondAPI::Request.get(@session, "/shop/images", params)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a single shop image.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.image(image_id)
    def image(image_id)
      response, status = BeyondAPI::Request.get(@session, "/shop/images/#{image_id}")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to create a shop image.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.create_image(body)
    def create_image(body)
      response, status = BeyondAPI::Request.post(@session, "/shop/images", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a shop image.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.delete_image(image_id)
    def delete_image(image_id)
      response, status = BeyondAPI::Request.delete(@session, "/shop/images/#{image_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is issued to search for shop images by label.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.search_images_by_label(label)
    def search_images_by_label(label)
      response, status = BeyondAPI::Request.get(@session, "/shop/images/search/find-by-label", { label: label })

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to upload a shop image. The body of the request must contain the content of the image.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.upload_image(image_binary, file_name, label)
    def upload_image(image_binary, file_name, label)
      response, status = BeyondAPI::Request.post(@session, "/shop/images?fileName=sample.png&label=invoice logo")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of the legal resource.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.legal_details
    def legal_details
      response, status = BeyondAPI::Request.get(@session, "/shop/legal")

      handle_response(response, status)
    end

    #
    # A +PATCH+ request is used to update a legal resource partially with json content type.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.update_legal_content(body)
    def update_legal_content(body)
      response, status = BeyondAPI::Request.patch(@session, "/shop/legal")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the legal content of a shop.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.legal_contents(params)
    def legal_contents(params)
      response, status = BeyondAPI::Request.get(@session, "/legal-content")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a specific part of the legal content information.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.legal_content(legal_content_type)
    def legal_content(legal_content_type)
      response, status = BeyondAPI::Request.get(@session, "/legal-content/right-of-withdrawal")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to update the content of a specific part of the legal content information. Changes on the properties type and mandatory will be ignored.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.update_legal_content(body)
    def update_legal_content(body)
      response, status = BeyondAPI::Request.put(@session, "/legal-content/legal-notice")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the details of a shop.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.current
    def current
      response, status = BeyondAPI::Request.get(@session, "/shop")

      handle_response(response, status)
    end

    #
    # A +PUT+ request is used to change attributes of a shop.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.update(body)
    def update(body)
      response, status = BeyondAPI::Request.patch(@session, "/shop")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to open a shop.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.open
    def open
      response, status = BeyondAPI::Request.post(@session, "/shop/open")

      handle_response(response, status)
    end

    #
    # A +POST+ request is used to close a shop.
    #
    # @scopes +ordr:r+
    #
    # @example
    #   session.shop.close
    def close
      response, status = BeyondAPI::Request.post(@session, "/shop/close")

      handle_response(response, status)
    end














    #
    # A +POST+ request is used to activate a webhook subscription.
    #
    # @scopes +ordr:r+, +prod:r+
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example
    #   session.webhook_subscriptions.activate("268a8629-55cd-4890-9013-936b9b5ea14c")
    #
    # def activate(webhook_subscription_id)
    #   response, status = BeyondAPI::Request.get(@session, "/webhook-subscriptions/#{webhook_subscription_id}/activate")

    #   handle_response(response, status, respond_with_true: true)
    # end

    #
    # A +GET+ request is used to list all of the webhook subscriptions in a paged way.
    #
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @webhook_subscriptions = session.webhook_subscriptions.all(size: 100, page: 0)
    #
    # def all(params)
    #   response, status = BeyondAPI::Request.get(@session, "/webhook-subscriptions", params)

    #   handle_response(response, status)
    # end

    #
    # A +POST+ request is used to create a webhook subscription.
    #
    # The scopes needed for the operation depend on the event types you register for. e.g. Order events require the scope +orde:r+.
    #
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "callback_uri" => "http://example.com/test",
    #     "event_types" => ["order.created", "product.created"]
    #   }
    #
    #   @webhook_subscription = session.webhook_subscriptions.create(body)
    #
    # def create(body)
    #   response, status = BeyondAPI::Request.post(@session, "/webhook-subscriptions", body)

    #   handle_response(response, status)
    # end

    #
    # A +POST+ request is used to deactivate a webhook subscription.
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example
    #   session.webhook_subscriptions.deactivate("a597cea4-b688-4164-8c56-b6568ea4d5aa")
    #
    # def deactivate(webhook_subscription_id)
    #   response, status = BeyondAPI::Request.get(@session, "/webhook-subscriptions/#{webhook_subscription_id}/deactivate")

    #   handle_response(response, status, respond_with_true: true)
    # end

    #
    # A +DELETE+ request is used to delete a webhook subscription.
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return true
    #
    # @example
    #   webhook_subscriptions = session.webhook_subscriptions.delete("c6076a5a-a8ad-443f-b20b-8a1b268b069e")
    #
    # def delete(webhook_subscription_id)
    #   response, status = BeyondAPI::Request.delete(@session, "/webhook-subscriptions/#{webhook_subscription_id}")

    #   handle_response(response, status, respond_with_true: true)
    # end

    #
    # A +GET+ request is used to retrieve the details of a webook subscription.
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @webhook_subscription = session.webhook_subscriptions.find("3d44ec71-768c-4927-9069-a96a5153e87c")
    #
    # def find(webhook_subscription_id)
    #   response, status = BeyondAPI::Request.get(@session, "/webhook-subscriptions/#{webhook_subscription_id}")

    #   handle_response(response, status)
    # end

    #
    # A +PUT+ request is used to update a subscription.
    #
    # The scopes needed for the operation depend on the event types you register for. e.g. Order events require the scope +orde:r+.
    #
    # @scopes +ordr:r+, +prod:r+
    #
    # @param webhook_subscription_id [String] the webhook subscription UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "callback_uri" => "http://example.com/test/updated",
    #     "event_types" => ["product.updated"]
    #   }
    #
    #   @webhook_subscription = session.webhook_subscriptions.update("6f3bc033-c2d1-4f44-80e3-1b668f6bd699", body)
    #
    # def update(webhook_subscription_id, body)
    #   response, status = BeyondAPI::Request.put(@session, "/webhook-subscriptions/#{webhook_subscription_id}", body)

    #   handle_response(response, status)
    # end
  end
end
