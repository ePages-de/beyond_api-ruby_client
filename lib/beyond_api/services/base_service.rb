module BeyondApi
  class BaseService
    include Connection # @session, @authorization

    ServiceSession = Struct.new(:api_url, :access_token, :refresh_token)

    def initialize(**params)
      @session = initialize_session(params)
      @authorization = :bearer
    end

    def fetch_all_pages(url, resource, params = {})
      if params[:paginated] == false
        result = fetch_pages(url, resource, params)
        adjust_response(result)
        result
      else
        fetch_page(url, 0, params)
      end
    end

    private

    def initialize_session(session)
      ServiceSession.new(
        session[:api_url],
        session[:access_token],
        session[:refresh_token]
      )
    end

    def adjust_response(result)
      result[:page][:size] = result[:page][:total_elements]
      result[:page][:total_pages] = 1
      result[:page][:number] = 0
    end

    # FIXME: find another way
    def fetch_page(url, page, params = {})
      params.merge!(page:, size: BeyondApi.configuration.all_pagination_size)
      BeyondApi::Request.new(@session).get(url, params)
    end

    def fetch_pages(url, resource, params)
      result = fetch_page(url, 0, params)

      (1..result[:page][:total_pages] - 1).each do |page|
        result[:embedded][resource].concat(
          fetch_page(url, page, params)[:embedded][resource]
        )
      end

      result
    end
  end
end
