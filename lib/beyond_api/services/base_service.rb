module BeyondApi
  class BaseService
    include BeyondApi::Utils

    attr_reader :session

    def initialize(session)
      @session = session

      # raise InvalidSessionError, "Invalid session" unless session.is_a? BeyondApi::Session
      # raise InvalidSessionError, "Session api_url cannot be nil" if session.api_url.nil?
    end

    def fetch_all_pages(url, resource, params = {})
      if params[:paginated] == false
        result = fetch_pages(url, resource, params, BeyondApi.configuration.all_pagination_size)
        adjust_response(result)
        result
      else
        fetch_page(url, params)
      end
    end

    private

    def adjust_response(result)
      result[:page][:size] = result[:page][:total_elements]
      result[:page][:total_pages] = 1
      result[:page][:number] = 0
    end

    def fetch_page(url, params = {})
      BeyondApi::Request.get(@session, url, params)
    end

    def fetch_pages(url, resource, params, size)
      result = fetch_page(url, params.merge(page: 0, size:))

      (1..result[:page][:total_pages] - 1).each do |page|
        result[:embedded][resource].concat(
          fetch_page(url, params.merge(page:, size:))[:embedded][resource]
        )
      end

      result
    end
  end
end
