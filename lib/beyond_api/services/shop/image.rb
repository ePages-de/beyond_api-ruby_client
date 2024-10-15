# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Image.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Image < BaseService
      # Create a shop image.
      #
      # @see https://developer.epages.com/beyond-docs/#create_shop_image
      #
      # @param body [String] the request body
      #
      # @return [Hash]
      #
      # @example
      #   @client.create(data_uri: 'file.png?hash=212-2323-4343', width: 250, height: 300, label: 'logo')
      def create(body)
        post('shop/images', body)
      end

      # Retrieve the images of a shop.
      #
      # @see https://developer.epages.com/beyond-docs/#list_shop_images
      #
      # @option params [Boolean] :paginated
      # @option params [Integer] :size the page size
      # @option params [Integer] :page the page number
      #
      # @return [Hash]
      #
      # @example
      #   @client.all(size: 100, page: 0)
      def all(params = {})
        fetch_all_pages('shop/images', params)
      end

      # Search for shop images by label.
      #
      # @see https://developer.epages.com/beyond-docs/#find_shop_images_by_label
      #
      # @param label [String] the label to search for
      #
      # @return [Hash]
      #
      # @example
      #   @client.find_by_label('logo')
      def find_by_label(label)
        get('shop/images/search/find-by-label', label:)
      end

      # Retrieve a single shop image.
      #
      # @see https://developer.epages.com/beyond-docs/#show_shop_image_details
      #
      # @param id [String] the image UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('de5eaacf-8e85-46cf-8bea-d629e52cf987')
      def find(id)
        get("shop/images/#{id}")
      end

      # Upload a shop image. The request body must contain the content of the shop image. The maximum image size for shop images is 8 MB.
      #
      # @see https://developer.epages.com/beyond-docs/#upload_shop_image
      #
      # @param image_path [String] the image path
      # @param image_name [String] the image file name
      # @param label [String] the image label
      #
      # @return [Hash]
      #
      # @example
      #   @client.upload('/home/epages/file.png', 'file.png', 'logo')
      def upload(image_path, image_name, label)
        upload_file('shop/images',
                    image_path,
                    'multipart/form-data',
                    { file_name: image_name, label: })
      end

      # Delete a shop image.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_shop_image
      #
      # @param id [String] the image UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('ec535cb3-3155-4c8f-b3cc-2bb94db7c530')
      def delete(id)
        super("shop/images/#{id}")
      end
    end
  end
end
