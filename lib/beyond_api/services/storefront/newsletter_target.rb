# frozen_string_literal: true

module BeyondApi
  module Storefront
    # @example How to instantiate a client
    #   @client = BeyondApi::Storefront::NewsletterTarget.new(api_url: 'https://example.com/api', access_token: 'your_token')
    class NewsletterTarget < BaseService
      # Retrieve the details of a newsletter target.
      #
      # @see https://developer.epages.com/beyond-docs/#show_newsletter_target_details
      #
      # @param id [String] The newsletter target id.
      #
      # @return [Hash]
      #
      # @example
      #  newsletter_target = @client.show('id')
      def show(id)
        get("newsletter-target/#{id}")
      end

      # Create a newsletter target.
      #
      # @see https://developer.epages.com/beyond-docs/#create_newsletter_target
      #
      # @param submit_url [String] The URL stating where to submit the newsletter form to.
      #
      # @return [Hash]
      #
      # @example
      #   newsletter_target = @client.create('https://example.com/cgi-bin/subscribe.php')
      def create(submit_url)
        post('newsletter-target', submit_url:)
      end

      # Update a newsletter target.
      #
      # @see https://developer.epages.com/beyond-docs/#update_newsletter_target
      #
      # @param id [String] The newsletter target id.
      # @param submit_url [String] The URL stating where to submit the newsletter form to.
      #
      # @return [Hash]
      #
      # @example
      #   newsletter_target = @client.update('id', 'https://example.com/cgi-bin/otherSubscribe.php')
      def update(id, submit_url)
        put("newsletter-target/#{id}", submit_url:)
      end

      # Delete a newsletter target.
      #
      # @see https://developer.epages.com/beyond-docs/#delete_newsletter_target
      #
      # @param id [String] The newsletter target id.
      #
      # @return [Hash]
      #
      # @example
      #   newsletter_target = @client.delete('id')
      def delete(id)
        super("newsletter-target/#{id}")
      end
    end
  end
end
