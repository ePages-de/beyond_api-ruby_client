# frozen_string_literal: true

require "ostruct"

module BeyondApi
  module Utils
    extend self

    def file_content_type(file_path)
      case File.extname(file_path)
      when ".png"
        "image/png"
      when ".jpg", ".jpeg"
        "image/jpeg"
      when ".gif"
        "image/gif"
      end
    end

    def handle_all_request(url, resource, params = {})
      paginated_size = BeyondApi.configuration.all_pagination_size

      if params[:paginated] == false
        result = all_paginated(url, params.merge(page: 0, size: paginated_size))

        (1..result[:page][:total_pages] - 1).each do |page|
          result[:embedded][resource].concat(
            all_paginated(url,
                          params.merge(page: page,
                                       size: paginated_size))[:embedded][resource]
          )
        end

        result[:page][:size] = result[:page][:total_elements]
        result[:page][:total_pages] = 1
        result[:page][:number] = 0

        result
      else
        all_paginated(url, params)
      end
    end

    private

    def all_paginated(url, params = {})
      BeyondApi::Request.get(@session, url, params)
    end
  end
end
