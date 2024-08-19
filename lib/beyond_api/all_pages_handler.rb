# frozen_string_literal: true

module BeyondApi
  class AllPagesHandler
    include Concerns::Connection

    def initialize(session, url, params = {})
      @session = session
      @url = url
      @params = params

      first_page_data = fetch_page(0)
      @response       = first_page_data
      @resource_key   = first_page_data[:embedded].keys.first
      @total_pages    = first_page_data.dig(:page, :total_pages)
      @total_elements = first_page_data.dig(:page, :total_elements)
    end

    def call
      (1..remaining_pages).each do |page|
        process_page(page)
      end

      update_response_page_info

      @response
    end

    private

    def remaining_pages
      @total_pages - 1
    end

    def fetch_page(page)
      # Fixed page size
      get(@url, @params.merge(page:, size: BeyondApi.configuration.all_pagination_size))
    end

    def process_page(page)
      page_data = fetch_page(page)

      @response[:embedded][@resource_key].concat(
        page_data[:embedded][@resource_key]
      )
    end

    def update_response_page_info
      @response[:page][:size] = @total_elements
      @response[:page][:total_pages] = 1
      @response[:page][:number] = 0
    end
  end
end
