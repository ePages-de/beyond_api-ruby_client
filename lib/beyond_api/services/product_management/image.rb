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
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(id, params = {})
        get("products/#{id}/images", params)
      end

      # Upload an image and add it to a product. The body of the request must contain the content of the image.
      # The maximum image size is 7000 × 7000 px, and the maximum file size per image is 8 MB.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_product_image
      #
      # @param id [String] the product UUID
      # @param id [String] the image path
      # @param id [String] the image file name
      #
      # @return [Hash]
      #
      # @example
      #   client.upload('4125b993-49fc-47c8-b9b3-76d8871e4e06', '/home/epages/file.png', 'file.png')
      def upload(product_id, image_path, image_name)
        upload_image("products/#{product_id}/images", image_path, file_name: image_name)
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
      #   client.upload('4125b993-49fc-47c8-b9b3-76d8871e4e06', image_paths, image_names)
      def upload_multiple(product_id, image_paths, image_names)
        upload_images("/products/#{product_id}/images",
                      image_paths,
                      file_name: image_names.map { |e| URI.encode_www_form([e]) })
      end
    end
  end
end
