# frozen_string_literal: true

require "beyond_api/utils"

module BeyondAPI
  class ProductViewCategories < Base
    include BeyondAPI::Utils

    def find(category_id)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/#{category_id}")

      handle_response(response, status)
    end

    def all(params)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories", params)

      handle_response(response, status)
    end

    def products(category_id, params)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/#{category_id}/products", params)

      handle_response(response, status)
    end

    def search_by_product_id(product_id, params)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/search/find-by-product?productId=#{product_id}", params)

      handle_response(response, status)
    end

    def search_by_product(body, params)
      response, status = BeyondAPI::Request.post(@session, "/product-view/categories/search/find-by-product", body, params)

      handle_response(response, status)
    end

    def search_by_label(label)
      response, status = BeyondAPI::Request.get(@session, "/product-view/categories/search/find-by-label?label=#{label}", params)

      handle_response(response, status)
    end
  end
end
