# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module VariationImages
    #
    # A +POST+ request is used to create an image and add it to a variation. The URL of the image will be assigned to the variation. The image URL has to be provided in body of the request.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/a08ca814-52e9-4e00-82a2-3e9b012e5f9d/variations/4b58cdb7-4d3d-419a-ae27-8469f8b04276/images' -i -X POST \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "dataUri" : "photostore-2.JPG?hash=8a627f655c68f56dfbbf217ab7d5563281225998",
    #       "width" : 100,
    #       "height" : 200
    #   }'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "data_uri" => "photostore-2.JPG?hash=8a627f655c68f56dfbbf217ab7d5563281225998",
    #     "width" => 100,
    #     "height" => 200
    #   }
    #   @image = session.variations.add_image("a08ca814-52e9-4e00-82a2-3e9b012e5f9d", "4b58cdb7-4d3d-419a-ae27-8469f8b04276", body)
    #
    def add_image(product_id, variation_id, body)
      path = "/products/#{product_id}/variations/#{variation_id}/images"

      response, status = BeyondApi::Request.post(@session,
                                                 path,
                                                 body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a variation image
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/8f5736f8-0a5f-4c08-bbac-3c524e2a6294/variations/86f3047c-ff29-4906-83c1-93e24ef88f3e/images/193d2ba4-3cf0-4326-a655-ef46e8a97c6a' -i -X DELETE \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param image_id [String] the image UUID
    #
    # @return [true]
    #
    # @example
    #   session.variations.delete_image("8f5736f8-0a5f-4c08-bbac-3c524e2a6294", "86f3047c-ff29-4906-83c1-93e24ef88f3e", "193d2ba4-3cf0-4326-a655-ef46e8a97c6a")
    #
    def delete_image(product_id, variation_id, image_id)
      path = "/products/#{product_id}/variations/#{variation_id}/images/#{image_id}"

      response, status = BeyondApi::Request.delete(@session,
                                                   path)

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve a single image of a variation.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/8665fc36-003e-4120-8a74-a9d6449644ae/variations/9163db42-92e7-418c-a3d8-651e7aaca569/images/86fc2691-5dfb-47e1-aae7-4bc2f658a80b' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param image_id [String] the image UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @image = session.variations.image("8665fc36-003e-4120-8a74-a9d6449644ae", "a9163db42-92e7-418c-a3d8-651e7aaca569", "86fc2691-5dfb-47e1-aae7-4bc2f658a80b")
    #
    def image(product_id, image_id)
      path = "/products/#{product_id}/variations/#{variation_id}/images/#{image_id}"

      response, status = BeyondApi::Request.get(@session,
                                                path)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the images of a variation.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/b4948e53-05af-4e0b-8877-28bc8811f73e/variations/50c5bf45-5dd6-4bae-babf-813c7cdca488/images' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @images = session.variations.images("b4948e53-05af-4e0b-8877-28bc8811f73e", "50c5bf45-5dd6-4bae-babf-813c7cdca488", size: 100, page: 0)
    #
    def images(product_id, variation_id, params = {})
      path = "/products/#{product_id}/variations/#{variation_id}/images"

      response, status = BeyondApi::Request.get(@session,
                                                path,
                                                params)

      handle_response(response, status)
    end

    # A +PUT+ request is used to sort the variation images. This is done by passing the self-links of the images to the desired variation. The request must contain URIs for all images of the given page.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/8a8a7002-f864-4011-9991-d6ffb1bd1085/variations/60c2c2a5-ece0-4d04-b90d-f38ee710961c/images' -i -X PUT \
    #     -H 'Content-Type: text/uri-list' \
    #     -H 'Authorization: Bearer <Access token>' \
    #     -d 'https://api-shop.beyondshop.cloud/api/products/8a8a7002-f864-4011-9991-d6ffb1bd1085/variations/60c2c2a5-ece0-4d04-b90d-f38ee710961c/images/a12cae49-3efb-4874-989e-37df6981a4db
    #         https://api-shop.beyondshop.cloud/api/products/8a8a7002-f864-4011-9991-d6ffb1bd1085/variations/60c2c2a5-ece0-4d04-b90d-f38ee710961c/images/4f562165-968c-42fd-a245-1dcc045f8151
    #         https://api-shop.beyondshop.cloud/api/products/8a8a7002-f864-4011-9991-d6ffb1bd1085/variations/60c2c2a5-ece0-4d04-b90d-f38ee710961c/images/93cd0802-15db-4772-b524-e1c4c6c27b77'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param images [Array] the image UUIDS
    #
    # @return true
    #
    # @example
    #   body = [
    #     "c9082802-a0d0-416e-9039-02fa465a027e",
    #     "78e9993d-8db3-45d8-8f76-6b8f2aea9c45",
    #     "9233ee97-5dbb-4c00-a7b2-e1512c69a938"
    #   ]
    #   session.variations.sort_images("3f4b2b56-c22d-4d80-b4ed-d5b33ed161eb", body)
    #
    def sort_images(product_id, variation_id, image_ids)
      body = image_ids.map { |image_id| "#{@session.api_url}/products/#{product_id}/variations/#{variation_id}/images/#{image_id}" }
      body = body.join("\n")
      response, status = BeyondApi::Request.put(@session, "/products/#{product_id}/variations/#{variation_id}/images", body, {}, 'text/uri-list')

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to upload an image to the image storage and assign the URL of the image to the variation. The body of the request must contain the content of the image.
    #
    #   $ curl --data-binary '@/home/epages/file.png' 'https://api-shop.beyondshop.cloud/api/products/4125b993-49fc-47c8-b9b3-76d8871e4e06/variations/d7fecf94-2e57-4122-8c94-a0acd840c111/images?fileName=file.png' -X POST \
    #       -H 'Content-Type: image/png' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param images_path [Array] the images path
    # @param images_name [Array] the images name
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "type" => "VIMEO",
    #     "source" => "https://vimeo.com/7265982"
    #   }
    #
    #   session.variations.upload_image("4125b993-49fc-47c8-b9b3-76d8871e4e06", "d7fecf94-2e57-4122-8c94-a0acd840c111", "/home/epages/file.png", "file.png")
    #
    def upload_image(product_id, variation_id, image_path, image_name)
      content_type = file_content_type(image_path)
      path = "/products/#{product_id}/variations/#{variation_id}/images"

      image_binary = File.binread(image_path)

      response, status = BeyondApi::Request.upload(@session,
                                                   path,
                                                   image_binary,
                                                   content_type,
                                                   { file_name: image_name })

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +POST+ request is used to upload up to 10 images to the image storage and assign the URL of the images to up to 30 variations. The body of the request must contain the content of the images.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/4125b993-49fc-47c8-b9b3-76d8871e4e06/variations/images?fileName=file.png&fileName=file2.png&variation=ca53ae26-e7c6-44a4-8070-9fca08cc87ed&variation=ab63fa3a-c2ac-4074-aaa3-b547217b042d' -i -X POST \
    #       -H 'Content-Type: multipart/form-data' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -F 'image=@/home/epages/file.png' \
    #       -F 'image=@/home/epages/file2.png'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param variation_id [String] the variation UUID
    # @param images_path [String] the image path
    # @param images_name [String] the image name
    #
    # @return [OpenStruct]
    #
    # @example
    #   session.variations.upload_multiple_images("4125b993-49fc-47c8-b9b3-76d8871e4e06", "d7fecf94-2e57-4122-8c94-a0acd840c111",
    #                                             ["/home/epages/file.png", "/home/epages/file2.png"], ["file.png", "file2.png"])
    #
    def upload_multiple_images(product_id, variation_id, images_path, images_name)
      response, status = BeyondApi::Request.upload_by_form(@session,
                                                           "/products/#{product_id}/variations/#{variation_id}/images",
                                                           images_path,
                                                           file_name: images_name)

      handle_response(response, status)
    end
  end
end
