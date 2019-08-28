# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class Categories < Base
    include BeyondAPI::Utils

    def all(params = {})
      response, status = BeyondAPI::Request.get(@session, "/categories", params)

      handle_response(response, status)
    end

    def create(body)
      response, status = BeyondAPI::Request.post(@session, "/categories", body)

      handle_response(response, status)
    end

    def find(category_id)
      response, status = BeyondAPI::Request.get(@session, "/categories/#{category_id}")

      handle_response(response, status)
    end

    def update(category_id, body)
      response, status = BeyondAPI::Request.put(@session, "/categories/#{category_id}", body)

      handle_response(response, status)
    end

    def patch(category_id, body)
      response, status = BeyondAPI::Request.patch(@session, "/categories/#{category_id}", body)

      handle_response(response, status)
    end

    def delete(category_id)
      response, status = BeyondAPI::Request.delete(@session, "/categories/#{category_id}")

      handle_response(response, status, respond_with_true: true)
    end
  end
end
