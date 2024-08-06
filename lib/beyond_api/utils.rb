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
  end
end
