# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Products < Base
    include BeyondAPI::Utils

    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/products", params)

      handle_response(response, status)
    end

    def find(product_id)
      response, status = BeyondAPI::Request.get(@session, "/products/#{product_id}")

      handle_response(response, status)
    end

    def create(body)
      response, status = BeyondAPI::Request.post(@session, "/products", body)

      handle_response(response, status)
    end

    def delete(product_id)
      response, status = BeyondAPI::Request.delete(@session, "/products/#{product_id}")

      handle_response(response, status, respond_with_true: true)
    end
  end
end
