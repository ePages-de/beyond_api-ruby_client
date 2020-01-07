# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ProductImages

    #
    # A +POST+ request is used to create an image and add it to a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/7a7d1f18-f760-46a9-b794-dbe5a88c6b44/images' -i -X POST \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #           "dataUri" : "photostore-2.JPG?hash=8a627f655c68f56dfbbf217ab7d5563281225998",
    #           "width" : 600,
    #           "height" : 300
    #       }'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param image_uri [String] the image url
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "data_uri" => "photostore-2.JPG?hash=8a627f655c68f56dfbbf217ab7d5563281225998",
    #     "width" => 600,
    #     "height" => 300
    #   }
    #   @image = session.products.add_image("7a7d1f18-f760-46a9-b794-dbe5a88c6b44", body)
    #
    def add_image(product_id, body)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/images", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product image.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/8f5e979e-4a47-47ca-84ce-7c026d623974/images/ac318d53-df29-4f43-9356-d91aed8bdb39' -i -X DELETE \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param image_id [String] the image UUID
    #
    # @return true
    #
    # @example
    #   session.products.delete_image("8f5e979e-4a47-47ca-84ce-7c026d623974", "ac318d53-df29-4f43-9356-d91aed8bdb39")
    #
    def delete_image(product_id, image_id)
      response, status = BeyondApi::Request.delete(@session, "/products/#{product_id}/images/#{image_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +GET+ request is used to retrieve the images of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/7f32696a-df56-4380-a91b-fffb97f025b4/images' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @option params [Integer] :size the page size
    # @option params [Integer] :page the page number
    #
    # @return [OpenStruct]
    #
    # @example
    #   @images = session.products.images("7f32696a-df56-4380-a91b-fffb97f025b4", { size: 20, page: 0 })
    #
    def images(product_id, params = {})
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/images", params)

      handle_response(response, status)
    end

    # A +GET+ request is used to retrieve a single image of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/124c5c94-4e62-410a-8599-e5b29dae3491/images/715f5154-9fde-4213-bcab-41ceaaf8b70e' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param image_id [String] the image UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @image = session.products.image("124c5c94-4e62-410a-8599-e5b29dae3491", "715f5154-9fde-4213-bcab-41ceaaf8b70e")
    #
    def image(product_id, image_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/images/#{image_id}")

      handle_response(response, status)
    end

    # A +PUT+ request is used to assign a product image as the default image. The request contains a single URI of the image to assign.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/150015b9-0b9b-45a2-bcfb-f9006b16a8b8/default-image' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Accept: application/json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'http://localhost/products/images/8ef3591c-d05f-4aa1-acf6-950ba51ec4f7'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param image_id [String] the image UUID
    #
    # @return true
    #
    # @example
    #   session.products.set_image_as_default("150015b9-0b9b-45a2-bcfb-f9006b16a8b8", "8ef3591c-d05f-4aa1-acf6-950ba51ec4f7")
    #
    def set_image_as_default(product_id, image_id)
      response, status = BeyondApi::Request.put(@session, "/products/#{product_id}",
                                                "#{@session.api_url}/images/#{image_id}")

      handle_response(response, status, respond_with_true: true)
    end

    # A +PUT+ request is used to sort the product images. This is done by passing the self-links of the images to the desired product. The request must contain URIs for all images of the given page.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/3f4b2b56-c22d-4d80-b4ed-d5b33ed161eb/images' -i -X PUT \
    #       -H 'Content-Type: text/uri-list' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d 'http://localhost/products/3f4b2b56-c22d-4d80-b4ed-d5b33ed161eb/images/c9082802-a0d0-416e-9039-02fa465a027e
    #           http://localhost/products/3f4b2b56-c22d-4d80-b4ed-d5b33ed161eb/images/78e9993d-8db3-45d8-8f76-6b8f2aea9c45
    #           http://localhost/products/3f4b2b56-c22d-4d80-b4ed-d5b33ed161eb/images/9233ee97-5dbb-4c00-a7b2-e1512c69a938'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
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
    #   session.products.sort_images("3f4b2b56-c22d-4d80-b4ed-d5b33ed161eb", body)
    #
    def sort_images(product_id, image_ids)
      body = image_ids.map { |image_id| "#{@session.api_url}/products/#{product_id}/images/#{image_id}" }
      response, status = BeyondApi::Request.put(@session, "/products/#{product_id}/images", body)

      handle_response(response, status, respond_with_true: true)
    end

    # A +POST+ request is used to upload an image and add it to a product. The body of the request must contain the content of the image.
    #
    #   $ curl --data-binary '@/home/epages/file.png' 'https://api-shop.beyondshop.cloud/api/products/4125b993-49fc-47c8-b9b3-76d8871e4e06/images?fileName=file.png' -X POST \
    #       -H 'Content-Type: image/png' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param image_path [String] the image path
    # @param image_name [String] the image name
    #
    # @return true
    #
    # @example
    #   session.products.upload_image("4125b993-49fc-47c8-b9b3-76d8871e4e06", "/home/epages/file.png", "file.png")
    #
    def upload_image(product_id, image_path, image_name)
      content_type = case File.extname(image_path)
        when ".png"
          "image/png"
        when ".jpg", ".jpeg"
          "image/jpeg"
        when ".gif"
          "image/gif"
        end
      image_binary = File.binread(image_path)

      response, status = BeyondApi::Request.upload(@session, "/products/#{product_id}/images", image_binary, content_type, { file_name: image_name })

      handle_response(response, status, respond_with_true: true)
    end
  end
end
