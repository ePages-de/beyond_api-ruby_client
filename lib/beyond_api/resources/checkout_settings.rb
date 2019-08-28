# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class CheckoutSettings < Base
    include BeyondAPI::Utils

    def all
      response, status = BeyondAPI::Request.get(@session, "/checkout-settings")

      handle_response(response, status)
    end

    def update(body)
      response, status = BeyondAPI::Request.put(@session, "/checkout-settings", body)

      handle_response(response, status)
    end
  end
end
