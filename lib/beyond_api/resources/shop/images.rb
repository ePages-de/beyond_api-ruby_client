# frozen_string_literal: true

module BeyondApi
  module Shop::Images
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
    #     "data_uri" => "file.png?hash=212-2323-4343",
    #     "label" => "logo"
    #   }
    #
    #   session.shop.create_image(body)
    #
    def create_image(body)
      response, status = BeyondApi::Request.post(@session, "/shop/images", body)

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
      response, status = BeyondApi::Request.delete(@session, "/shop/images/#{image_id}")

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
    #   @image = session.shop.image("2feee7ac-f1cb-4faf-9488-f3ce07394141")
    #
    def image(image_id)
      response, status = BeyondApi::Request.get(@session, "/shop/images/#{image_id}")

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
    #   @images = session.shop.images(size: 5, page: 1)
    #
    def images(params = {})
      response, status = BeyondApi::Request.get(@session, "/shop/images", params)

      handle_response(response, status)
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
      response, status = BeyondApi::Request.get(@session, "/shop/images/search/find-by-label", { label: label })

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

      response, status = BeyondApi::Request.upload(@session,
                                                   "/shop/images",
                                                   image_binary,
                                                   content_type,
                                                   { file_name: image_name, label: label })

      handle_response(response, status, respond_with_true: true)
    end
  end
end
