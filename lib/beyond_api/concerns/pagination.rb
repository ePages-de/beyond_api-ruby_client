# frozen_string_literal: true

module BeyondApi
  module Concerns
    module Pagination
      def fetch_all_pages(url, params = {})
        if params[:paginated] == false
          AllPagesHandler.new(@session, url, params).call
        else
          get(url, params)
        end
      end
    end
  end
end
