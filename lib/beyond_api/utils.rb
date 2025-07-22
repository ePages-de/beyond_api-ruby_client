# frozen_string_literal: true

require 'ostruct'

module BeyondApi
  module Utils
    def self.file_content_type(file_path)
      case File.extname(file_path)
      when '.png'
        'image/png'
      when '.jpg', '.jpeg'
        'image/jpeg'
      when '.gif'
        'image/gif'
      end
    end

    def self.camelize_keys(input)
      case input
      when Array
        input.map { |item| camelize_keys(item) }
      when Hash
        input.deep_transform_keys { |key| key.to_s.camelize(:lower) }
      else
        input
      end
    end

    def self.faraday_file_parts(file_paths)
      file_paths.map do |file_path|
        Faraday::FilePart.new(File.open(file_path), Utils.file_content_type(file_path))
      end
    end

    def self.encode_filenames(filenames)
      filenames.map { |e| URI.encode_www_form([e]) }
    end
  end
end
