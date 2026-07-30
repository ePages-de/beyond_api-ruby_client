# frozen_string_literal: true

module BeyondApi
  module ProductManagement
    # @example How to instantiate a client
    #   @client = BeyondApi::ProductManagement::Image.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Image < BaseService
      # Retrieve the images of a product.
      #
      # @see https://developer.epages.com/beyond-docs/#list_product_images
      #
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(id, params = {})
        fetch_all_pages("products/#{id}/images", params)
      end

      # Upload an image and add it to a product. The body of the request must contain the content of the image.
      # The maximum image size is 7000 × 7000 px, and the maximum file size per image is 8 MB.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_product_image
      #
      # @param product_id [String] the product UUID
      # @param image_path [String] the image path
      # @param image_name [String] the image file name
      #
      # @return [Hash]
      #
      # @example
      #   @client.upload('4125b993-49fc-47c8-b9b3-76d8871e4e06', '/home/epages/file.png', 'file.png')
      def upload(product_id, image_path, image_name)
        upload_file("products/#{product_id}/images",
                    image_path,
                    Utils.file_content_type(image_path),
                    file_name: image_name)
      end

      # Upload up to 10 images and add them to a product. The body of the request must contain the content of the images.
      # The maximum image size is 7000 × 7000px, and the maximum file size per image is 8 MB.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_multiple_product_images
      #
      # @param id [String] the product UUID
      # @param id [Array] an array of strings containing the path of each image
      # @param id [Array] an array of strings containing the file name of each image
      #
      # @return [Hash]
      #
      # @example
      #   image_paths = ['/home/epages/file1.png', '/home/epages/file2.png']
      #   image_names = ['file1.png', 'file2.png']
      #   @client.upload('4125b993-49fc-47c8-b9b3-76d8871e4e06', image_paths, image_names)
      def upload_multiple(product_id, image_paths, image_names)
        upload_files("products/#{product_id}/images",
                     { image: Utils.faraday_file_parts(image_paths) }, # body
                     { file_name: Utils.encode_filenames(image_names) }) # params
      end

      # Upload an image from an external resource and add it to a product. The body of the request must contain a single URI of the image to be uploaded.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_external_product_image
      #
      # @param product_id [String] the product UUID
      # @param uri [String] the URI of the image to be uploaded
      # @param file_name [String] the file name of the image (optional)
      #
      # @return [Hash]
      #
      # @example
      #   @client.upload_external('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                           'https://epages.com/wp-content/uploads/2019/08/my-image.jpg',
      #                           'external-img.jpg')
      def upload_external(product_id, uri, file_name = '')
        file_name = File.basename(URI.parse(uri).path) if file_name.empty?

        post("products/#{product_id}/external-images", { data_uri: uri }, { file_name: })
      end

      # Delete a product image.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_product_image
      #
      # @param product_id [String] the product UUID
      # @param image_id [String] the image UUID
      #
      # @return [nil]
      #
      # @example
      #   @client.delete('4125b993-49fc-47c8-b9b3-76d8871e4e06', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890')
      def delete(product_id, image_id)
        super("products/#{product_id}/images/#{image_id}") # Concerns::Connection delete method
      end

      # Sort the images of a product. The API expects a `text/uri-list` body
      # with the absolute URIs of the images in the desired order.
      #
      # @see https://developer.epages.com/beyond-docs/#sort_product_images
      #
      # @param product_id [String] the product UUID
      # @param image_ids [Array<String>] the image UUIDs in the desired order
      #
      # @return [Hash]
      #
      # @example
      #   @client.sort('4125b993-49fc-47c8-b9b3-76d8871e4e06',
      #                 ['a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'b2c3d4e5-f678-90ab-cdef-1234567890ab'])
      def sort(product_id, image_ids)
        uris = Array(image_ids).compact.map do |image_id|
          "#{@session.api_url}/products/#{product_id}/images/#{image_id}"
        end
        put_uri_list("products/#{product_id}/images", uris)
      end
    end
  end
end
