# frozen_string_literal: true

class Hash
  def deep_transform_keys(&block)
    result = {}
    each do |key, value|
      result[yield(key)] = case value
                           when Hash
                             value.deep_transform_keys(&block)
                           when Array
                             value.camelize_keys
                           else
                             value
                           end
    end
    result
  end

  def camelize_keys
    deep_transform_keys { |key| key.to_s.camelize(false) }
  end

  def underscorize_keys
    deep_transform_keys { |key| key.to_s.underscore }
  end
end
