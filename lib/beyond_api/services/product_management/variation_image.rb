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
      def all(product_id, variation_id, params = {})
        fetch_all_pages("products/#{product_id}/variations/#{variation_id}/images", params)
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

      # Upload an image and add it to a variation. The body of the request must contain the content of the image.
      # The maximum image size is 7000 x 7000 px, and the maximum file size per image is 8 MB.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_variation_image
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param image_path [String] the image path
      # @param image_name [String] the image file name
      #
      # @return [Hash]
      #
      # @example
      #   @client.upload('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
      #                  '/home/epages/file.png', 'file.png')
      def upload(product_id, variation_id, image_path, image_name)
        upload_file("products/#{product_id}/variations/#{variation_id}/images",
                    image_path,
                    Utils.file_content_type(image_path),
                    file_name: image_name)
      end

      # Upload multiple images and add them to a variation. Each image is uploaded
      # in a separate request because the variation image endpoint accepts a single
      # raw binary body per call.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_variation_image
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param image_paths [Array<String>] an array of image paths
      # @param image_names [Array<String>] an array of image file names
      #
      # @return [Array<Hash>] one response per uploaded image
      #
      # @example
      #   image_paths = ['/home/epages/file1.png', '/home/epages/file2.png']
      #   image_names = ['file1.png', 'file2.png']
      #   @client.upload_multiple('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                           'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
      #                           image_paths, image_names)
      def upload_multiple(product_id, variation_id, image_paths, image_names)
        image_paths.each_with_index.map do |path, index|
          upload(product_id, variation_id, path, image_names[index])
        end
      end

      # Delete a variation image.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_variation_image
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param image_id [String] the image UUID
      #
      # @return [nil]
      #
      # @example
      #   @client.delete('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                  'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
      #                  'b2c3d4e5-f678-90ab-cdef-1234567890ab')
      def delete(product_id, variation_id, image_id)
        # Concerns::Connection delete method
        super("products/#{product_id}/variations/#{variation_id}/images/#{image_id}")
      end

      # Sort the images of a variation. The API expects a `text/uri-list` body
      # with the absolute URIs of the images in the desired order.
      #
      # @see https://developer.epages.com/beyond-docs/#sort_variation_images
      #
      # @param product_id [String] the product UUID
      # @param variation_id [String] the variation UUID
      # @param image_ids [Array<String>] the image UUIDs in the desired order
      #
      # @return [Hash]
      #
      # @example
      #   @client.sort('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
      #                ['b2c3d4e5-f678-90ab-cdef-1234567890ab', 'c3d4e5f6-7890-abcd-ef1234567890ab'])
      def sort(product_id, variation_id, image_ids)
        uris = Array(image_ids).compact.map do |image_id|
          "#{@session.api_url}/products/#{product_id}/variations/#{variation_id}/images/#{image_id}"
        end
        put_uri_list("products/#{product_id}/variations/#{variation_id}/images", uris)
      end
    end
  end
end
