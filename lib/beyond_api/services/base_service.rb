module BeyondApi
  class BaseService
    include Concerns::Connection # @session, @authorization
    include Concerns::Pagination

    ServiceSession = Struct.new(:api_url, :access_token, :refresh_token)

    def initialize(**params)
      @session = initialize_session(params)
      @authorization = :bearer
    end

    private

    def initialize_session(session)
      ServiceSession.new(
        session[:api_url],
        session[:access_token],
        session[:refresh_token]
      )
    end
  end
end
