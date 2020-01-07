# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module ProductVideos

    #
    # A +POST+ request is used to create a video and add it to a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/f7716244-568c-4536-bc25-317030f83395/videos' -i -X POST \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "type" : "VIMEO",
    #       "source" : "https://vimeo.com/7265982"
    #   }'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "type" => "VIMEO",
    #     "source" => "https://vimeo.com/7265982"
    #   }
    #   @video = session.products.add_video("f7716244-568c-4536-bc25-317030f83395", body)
    #
    def add_video(product_id, body)
      response, status = BeyondApi::Request.post(@session, "/products/#{product_id}/videos", body)

      handle_response(response, status)
    end

    #
    # A +DELETE+ request is used to delete a product video
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/1cc9ef5e-62b1-43c7-8745-f4aa8be79934/videos/60869f60-1a4b-4013-b86c-00a2ab9ddc2c' -i -X DELETE \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param video_id [String] the video UUID
    #
    # @return [true]
    #
    # @example
    #   session.products.delete_video("1cc9ef5e-62b1-43c7-8745-f4aa8be79934", "60869f60-1a4b-4013-b86c-00a2ab9ddc2c")
    #
    def delete_video(product_id, video_id)
      response, status = BeyondApi::Request.delete(@session, "/products/#{product_id}/videos/#{video_id}")

      handle_response(response, status, respond_with_true: true)
    end

    #
    # A +PUT+ request is used to update a video.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/9d33da61-1f60-4ad3-9de0-2f1dc0910ebb/videos/ef51af21-5381-4ccb-a107-8bfa574d3556' -i -X PUT \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>' \
    #       -d '{
    #       "type" : "VIMEO",
    #       "source" : "https://vimeo.com/7265982"
    #   }'
    #
    # @beyond_api.scopes +prod:u+
    #
    # @param product_id [String] the product UUID
    # @param video_id [String] the video UUID
    # @param body [Hash] the request body
    #
    # @return [OpenStruct]
    #
    # @example
    #   body = {
    #     "type" => "VIMEO",
    #     "source" => "https://vimeo.com/7265982"
    #   }
    #   @video = session.products.update_video("9d33da61-1f60-4ad3-9de0-2f1dc0910ebb", "ef51af21-5381-4ccb-a107-8bfa574d3556", body)
    #
    def update_video(product_id, video_id, body)
      response, status = BeyondApi::Request.put(@session, "/products/#{product_id}/videos/#{video_id}", body)

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve a single video of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/94c3baf9-1390-4bf8-a6c1-fb234533fa14/videos/ada27b8c-ddf0-489a-9143-5bec938c1e17' -i -X GET \
    #       -H 'Content-Type: application/hal+json' \
    #       -H 'Accept: application/hal+json' \
    #       -H 'Authorization: Bearer <Access token>'
    #
    # @beyond_api.scopes +prod:r+
    #
    # @param product_id [String] the product UUID
    # @param video_id [String] the video UUID
    #
    # @return [OpenStruct]
    #
    # @example
    #   @video = session.products.video("94c3baf9-1390-4bf8-a6c1-fb234533fa14", "ada27b8c-ddf0-489a-9143-5bec938c1e17")
    #
    def video(product_id, video_id)
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/videos/#{video_id}")

      handle_response(response, status)
    end

    #
    # A +GET+ request is used to retrieve the videos of a product.
    #
    #   $ curl 'https://api-shop.beyondshop.cloud/api/products/04c6ad65-465d-405e-a428-f73349104b65/videos' -i -X GET \
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
    #   @videos = session.products.videos("04c6ad65-465d-405e-a428-f73349104b65", size: 100, page: 0)
    #
    def videos(product_id, params =  {})
      response, status = BeyondApi::Request.get(@session, "/products/#{product_id}/videos", params)

      handle_response(response, status)
    end
  end
end
