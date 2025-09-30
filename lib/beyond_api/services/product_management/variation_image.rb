# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::VariationImage.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class VariationImage < BaseService
      # Retrieve the images of a single variation of a variation product in a paged manner.
      #
      # @see https://developer.epages.com/beyond-docs/#list_variation_images
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(product_id, variation_id, _params = {})
        get("products/#{product_id}/variations/#{variation_id}/images")
      end

      # A POST request is used to upload an image from an external resource and add it to a variation. The body of the request must contain a single URI of the image to be uploaded.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_external_variation_image
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param uri [String] the URI of the image to be uploaded
      # @param file_name [String] the file name of the image (optional)
      #
      # @return [Hash]
      #
      # @example
      #   @client.upload_external('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                           'b1e2c3d4-5678-90ab-cdef-1234567890ab',
      #                           'https://epages.com/wp-content/uploads/2019/08/my-image.jpg',
      #                           'external-img.jpg')
      def upload_external(product_id, variation_id, uri, file_name = '')
        file_name = File.basename(URI.parse(uri).path) if file_name.empty?

        post("products/#{product_id}/variations/#{variation_id}/external-images", { data_uri: uri }, { file_name: })
      end
    end
  end
end
