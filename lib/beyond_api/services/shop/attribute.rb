# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Attribute.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Attribute < BaseService
      # Create a shop attribute.
      #
      # @see https://developer.epages.com/beyond-docs/#create_shop_attribute
      #
      # @param name [String] the attribute name
      # @param value [String] the attribute value
      # @param public [Boolean] flag to indicate if the attribute is public
      #
      # @return [Hash]
      #
      # @example
      #   @client.create('createSku', 'autogenerateSku', true)
      def create(name, value, public)
        post('shop/attributes', { name:, value:, public: })
      end

      # List of all shop attributes.
      #
      # @see https://developer.epages.com/beyond-docs/#list_shop_attributes
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
        fetch_all_pages('shop/attributes', params)
      end

      # Retrieve a particular shop attribute by its name.
      #
      # @see https://developer.epages.com/beyond-docs/#show_shop_attribute_details
      #
      # @param name [String] the attribute name
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('createSku')
      def find(name)
        get("shop/attributes/#{name}")
      end

      # Update a shop attribute. This operation is idempotent and will create a new shop attribute if required.
      #
      # @see https://developer.epages.com/beyond-docs/#update_shop_attribute
      #
      # @param name [String] the attribute name
      # @param value [String] the attribute value
      # @param public [Boolean] flag to indicate if the attribute is public
      #
      # @return [Hash]
      #
      # @example
      #   @client.update('createSku', 'autogenerateSku', false)
      def update(name, value, public)
        put("shop/attributes/#{name}", { value:, public: })
      end

      # Delete a shop attribute.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_shop_attribute
      #
      # @param name [String] the attribute name
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('createSku')
      def delete(name)
        super("shop/attributes/#{name}")
      end
    end
  end
end
