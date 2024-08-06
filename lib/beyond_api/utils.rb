# frozen_string_literal: true

require "ostruct"

module BeyondApi
  module Utils
    def self.file_content_type(file_path)
      case File.extname(file_path)
      when ".png"
        "image/png"
      when ".jpg", ".jpeg"
        "image/jpeg"
      when ".gif"
        "image/gif"
      end
    end

    def self.camelize_keys(hash)
      hash.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end
  end
end
