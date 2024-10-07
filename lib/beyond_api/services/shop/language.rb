# frozen_string_literal: true

module BeyondApi
  module Shop
    # @example How to instantiate a client
    #   @client = BeyondApi::Shop::Language.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class Language < BaseService
      # Create a language for a specified shop.
      #
      # @see https://developer.epages.com/beyond-docs/#create_language
      #
      # @param locale [String] the locale
      #
      # @return [Hash]
      #
      # @example
      #   @client.create('de-DE')
      def create(locale)
        post('shop/languages', locale:)
      end

      # Retrieve detailed information about a single language of the shop. The language is specified by its id.
      #
      # @see https://developer.epages.com/beyond-docs/#show_language_details
      #
      # @param id [String] The language UUID
      #
      # @return [Hash]
      #
      # @example
      #   @client.find('750958a7-7924-4028-8f44-260f8fb11cbb')
      def find(id)
        get("shop/languages/#{id}")
      end

      # Retrieve the currently active languages of a specified shop in a paged way.
      #
      # @see https://developer.epages.com/beyond-docs/#list_languages
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
        fetch_all_pages('shop/languages', params)
      end

      # Retrieve all languages that can be created for a shop. Languages that are not on the list are not supported.
      #
      # @see https://developer.epages.com/beyond-docs/#list_supported_languages
      #
      # @return [Hash]
      #
      # @example
      #   @client.supported_languages
      def supported_languages
        get('shop/languages/supported')
      end

      # Delete a language from a specified shop.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_language
      #
      # @param id [String] the language UUID
      #
      # @return [Hash] an empty hash
      #
      # @example
      #   @client.delete('750958a7-7924-4028-8f44-260f8fb11cbb')
      def delete(id)
        super("shop/languages/#{id}")
      end
    end
  end
end
